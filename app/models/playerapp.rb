class Playerapp < ApplicationRecord
  include Discord
  include Wowarmory
  include Warcraftlogs

  has_many :playerappanswers, dependent: :destroy
  accepts_nested_attributes_for :playerappanswers

  before_create :generate_viewkey
  after_commit :send_to_discord_job

  validates :player_name, presence: true
  validates :player_class, inclusion: { in: %w[Druid Hunter Mage Paladin Priest Rogue Shaman Warlock Warrior DeathKnight Monk DemonHunter] }
  validates :player_spec, presence: true

  def player_links_split
    player_links.split(' / ') unless player_links.nil?
  end

  def link_warcraftlogs
    player_links_split.each do |value|
      return value if value.include? 'warcraftlogs.com'
    end
    'not found'
  end

  def link_raiderio
    player_links_split.each do |value|
      return value if value.include? 'raider.io'
    end
    'not found'
  end

  def link_wowprog
    player_links_split.each do |value|
      return value if value.include? 'wowprogress.com'
    end
    'not found'
  end

  def player_rank(score)
    max_score = ((100 * 11) + 101 + (989 + 15) + 11)
    increase = (max_score - player_rating).to_f
    percent = ((increase / max_score) * 100).to_f.round
    (100 - percent)
  end

  def player_suggestion
    player_score = player_rating
    rank = player_rank(player_score)

    case rank
    when 40..49
      "\nPlayer score: #{player_score} / #{((100 * 11) + 101 + (989 + 15) + 11)}\n" \
      "Rating: __Weak applicant__\n"
    when 50..69
      "\nPlayer score: #{player_score} / #{((100 * 11) + 101 + (989 + 15) + 11)}\n" \
      "Rating: __Good applicant__\n"
    when 70..100
      "\nPlayer score: #{player_score} / #{((100 * 11) + 101 + (989 + 15) + 11)} \n" \
      "Rating: __Strong applicant__\n"
    else
      "\nPlayer score: #{player_score} / #{((100 * 11) + 101 + (989 + 15) + 11)} \n" \
      "Rating: __Bad applicant__\n"
    end
  end

  def player_rating
    total_score = 0
    armory = armory(player_name, player_realm)
    return 0 if armory == false
    log_type = healer?(armory) ? 'hps' : 'dps'
    logs = playerlogs(player_name, player_realm, log_type)
    logs == false ? total_score += 0 : total_score += mythic_parses(logs)
    ilvl = armory['items']['averageItemLevelEquipped'].to_i
    weapon_level = weapon_info(armory['items'], player_spec_is(armory['talents']))
    progression = raid_progression(armory['progression'])
    total_score += (progression + ilvl + weapon_level)
    total_score
  end

  def send_to_discord
    send_to_recruitment_channel(
      "**New application submitted**\n\n" \
      "**Name:** #{player_name}\n" \
      "**Battle.net:** #{player_bnettag}\n" \
      "**Class:** #{player_class}\n" \
      "**Spec:** #{player_spec}\n\n" \
      "**Rating information:** #{player_suggestion}\n\n" \
      "**Logs:** #{link_warcraftlogs}\n" \
      "**WoW Progress:** #{link_wowprog}\n" \
      "**Raider.io:** #{link_raiderio}\n\n" \
      "Click here to view: https://www.isogguild.com/app/#{id}?viewkey=#{viewkey}"
    )
  end

  private

  def send_to_discord_job
    SendToDiscordWorker.perform_async(self.id)
  end

  def generate_viewkey
    self.viewkey = SecureRandom.urlsafe_base64
  end
end
