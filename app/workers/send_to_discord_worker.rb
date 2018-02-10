class SendToDiscordWorker
  include Sidekiq::Worker

  def perform(playerapp_id)
    app = Playerapp.find(playerapp_id)
    app.send_to_discord
  end
end
