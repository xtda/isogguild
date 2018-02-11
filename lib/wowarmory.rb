require 'rest-client'
# WoW API helpers
module Wowarmory
  WOW_API_KEY = Rails.application.secrets.battle_net_api_key
  API_URL = 'https://us.api.battle.net'.freeze
  REALMS_END_POINT = '/wow/realm/status'.freeze

  def armory(name, realm, region = 'us')
    uri = URI.encode("https://#{region}.api.battle.net/wow/character/#{realm}/#{name}?fields=items,progression,guild,achievements,talents&apikey=#{WOW_API_KEY}")
    request = RestClient.get(uri)
    character = JSON.parse(request)
    return if character['status'] == 'nok'
    character
  end

  def player_class_is(value)
    classes = ['Warrior', 'Paladin', 'Hunter', 'Rogue', 'Priest', \
               'Death Knight', 'Shaman', 'Mage', 'Warlock', \
               'Monk', 'Druid', 'Demon Hunter'].freeze
    classes.at(value - 1)
  end

  def player_spec_is(value)
    value.each do |key|
      if key['selected'] == true
        return key['spec']['name']
      end
    end
  end

  def weapon_info(items, player_spec)
    player_spec == 'protection' ? weapon_info = items['offHand']['artifactTraits'] : weapon_info = items['mainHand']['artifactTraits']
    weapon_info.map { |s| s['rank'] }.reduce(0, :+) - 3
  end

  def healer?(player)
    spec = player_spec_is(player['talents'])
    return true if spec == 'Holy' || spec == 'Discipline' || spec == 'Restoration' || spec == 'Mistweaver' 
    false
  end

  def ranged?(player)
    player_spec = player_spec_is(player['talents'])
    player_class = player['class']
    return true if player_class == 5 || player_class == 8 || \
                   player_class == 9 || player_spec == 'Balance' || \
                   player_spec == 'Survival' || player_spec == 'Elemental'
    false
  end

  def raid_progression(armory_progression)
    progression = 0
    valid_raids = [
      'Antorus, the Burning Throne'
    ].freeze
    armory_progression['raids'].each do |raid|
      valid_raids.each do |raids|
        if raid['name'] == raids
          raid['bosses'].each do |boss|
            if boss['mythicKills'] > 0
              progression += 1
            end
          end
        end
      end
    end
    progression - 1
  end

  def realm_list
    uri = URI.encode("#{API_URL}#{REALMS_END_POINT}?apikey=#{WOW_API_KEY}")
    request = RestClient.get(uri)
    realms = JSON.parse(request)
    realm_list = []
    realms['realms'].each do |k, v|
      realm = {
        name: k['name'],
        slug: k['slug']
      }
      realm_list.push(realm)
    end
    realm_list
  end
end
