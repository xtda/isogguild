require 'rest-client'
# Helpers to send messages to discord via webhook api https://support.discordapp.com/hc/en-us/articles/228383668
module Discord

  WEBHOOK_KEY = Rails.application.secrets.discord_webhook_key
  RECRUITMENT_CHANNEL_ID = Rails.application.secrets.discord_channel_id

  WEBHOOK_ENDPOINT = 'https://discordapp.com/api/webhooks'.freeze

  def send_to_recruitment_channel(content)
    send_message(RECRUITMENT_CHANNEL_ID, WEBHOOK_KEY, content)
  end

  private

  def send_message(channel, token, content, username = 'Morpheus')
    RestClient.post(
      "#{WEBHOOK_ENDPOINT}/#{channel}/#{token}", {
        content: content, username: username
      }.to_json,
      content_type: :json, accept: :json
    )
  end
end
