require 'digest'

class IpDigester
  class << self
    #
    # Digest an IP Address adding a salt that is generated new everyday.
    # So that the IP Address can be recognized only in the same day and 
    # appearing different the day after.
    #
    # @param [String] ip
    #
    # @return [String]
    #
    def call(ip:)
      Digest::SHA256.hexdigest(salt.to_s + ip)
    end

    private

    def salt
      @last_day ||= nil

      if Time.now.strftime('%Y-%m-%d') != @last_day
        @last_day = Time.now.strftime('%Y-%m-%d')
        @salt = rand(1_000_000)
      end

      @salt
    end
  end
end
