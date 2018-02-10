require 'rest-client'
# Warcraftlogs api helper used to get parses
module Warcraftlogs
  WCL_API_KEY = Rails.application.secrets.warcraftlogs_api_key
  WCL_API_URL = 'https://www.warcraftlogs.com:443/v1/'.freeze
  WCL_PARSES_API_END_POINT = 'parses/character/'.freeze

  def playerlogs(name, realm, role = 'dps', region = 'us')
    uri = URI.encode("#{WCL_API_URL}#{WCL_PARSES_API_END_POINT}#{name}/#{realm}/#{region}?metric=#{role}&api_key=#{WCL_API_KEY}")
    request = RestClient.get(uri)
    JSON.parse(request)
  end

  def mythic_parses(logs)
    total_percent = 0
    logs.each do |k|
      highest_percent = 0
      next unless k['difficulty'] == 5
      k['specs'].first['data'].each do |spec|
        if highest_percent.round < spec['percent'].round
          highest_percent = spec['percent'].round
        end
      end
      total_percent += highest_percent
    end
    total_percent
  end
end
