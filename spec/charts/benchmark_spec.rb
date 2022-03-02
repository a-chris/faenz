require 'rails_helper'
require 'benchmark'

RSpec.describe GeolocationIp do
  describe 'benchmark' do
    it 'works' do
      domain = Domain.create!(base_url: 'example.com')
      100_000.times.map do
        Visit.create(
          domain_id: domain.id,
          width: 1024,
          event: 'pageview',
          url: 'https://example.com/homepage',
          ip: Faker::Internet.public_ip_v4_address,
          geo: {
            lat: Faker::Address.latitude,
            lng: Faker::Address.longitude,
            country: Faker::Address.country,
            country_code: Faker::Address.country_code,
            region: Faker::Address.state,
            city: Faker::Address.city,
            time_at: rand(0..24).hours.ago
          }
        )
      end

      start_date = Time.now - 1.week
      Benchmark.bmbm do |x|
        x.report('VISITS') { Visits.new(domain: domain, start_date: start_date) }
        x.report('TOP HOURS') { TopHours.new(domain: domain, start_date: start_date) }
        x.report('TOP SOURCES') { TopSources.new(domain: domain, start_date: start_date) }
        x.report('TOP PAGES') { TopPages.new(domain: domain, start_date: start_date) }
      end
    end
  end
end
