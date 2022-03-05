require 'net/http'

class GeolocationIp
  class << self
    API_KEY = Env.geoip_api_key

    def call(ip:)
      return {} if ip == '::1'

      response = Net::HTTP.get(URI("https://api.freegeoip.app/json/#{ip}?apikey=#{API_KEY}"))
      response = JSON.parse(response, symbolize_names: true)
      {
        country: response[:country_name],
        country_code: response[:country_code],
        region: response[:region_name],
        city: response[:city],
        lat: response[:latitude],
        lng: response[:longitude]
      }
    rescue StandardError => e
      {}
    end
  end
end
