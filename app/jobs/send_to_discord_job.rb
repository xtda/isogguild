class SendToDiscordJob < ApplicationJob
  queue_as :default

  def perform(playerapp)
    playerapp.send_to_discord
  end
end
