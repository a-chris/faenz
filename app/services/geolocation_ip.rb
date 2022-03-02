require 'net/http'

class GeolocationIp
  class << self
    API_KEY = 'cd647090-9755-11ec-81d6-91e0f9d27435'

    def call(ip:)
      ip = '93.34.226.136' if ip == "::1"
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
    end
  end
end
