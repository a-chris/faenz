# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
['https://museigratis.com', 'https://museigratis.it'].each do |url|
  Domain.find_or_create_by!(base_url: url)
end
domain = Domain.find_or_create_by!(base_url: 'https://achris.me')
if Visit.count.zero?
  1_000.times.map do
    Visit.create!(
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
        city: Faker::Address.city
      },
      time_at: rand(0..24).hours.ago
    )
  end
end
