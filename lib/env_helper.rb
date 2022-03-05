# frozen_string_literal

module EnvHelper
  class << self
    def geoip_api_key
      env_or_credentials(:geoip_api_key)
    end

    #
    # @param [String/Symbol] key
    #
    # @return [String/Integer]
    #
    def env_or_credentials(key)
      ENV[key.to_s] || Rails.application.credentials[key.to_sym]
    end
  end
end
