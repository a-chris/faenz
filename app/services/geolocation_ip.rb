require 'net/http'

#
# Geolocate the IP address using the IP Geolocation APIs
# https://ipgeolocation.io/documentation/ip-geolocation-api.html
#
class GeolocationIp
  class << self
    API_KEY = ENV['GEOIP_API_KEY']

    def call(ip:)
      return {} if ip == '::1'
      return {} if API_KEY.nil?

      Rails.cache.fetch("geolocation_ip_#{ip}", expires_in: 23.hours) do
        response = Net::HTTP.get(URI("https://api.ipgeolocation.io/ipgeo?apiKey=#{API_KEY}&ip=#{ip}"))
        response = JSON.parse(response, symbolize_names: true)
        {
          country: response[:country_name],
          country_code: response[:country_code2],
          region: response[:state_prov],
          city: response[:city],
          lat: response[:latitude],
          lng: response[:longitude]
        }
      end
    rescue StandardError => e
      {}
    end
  end
end
