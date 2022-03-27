return if Rails.env != 'development'

['museigratis.com', 'museigratis.it'].each do |url|
  Domain.find_or_create_by!(base_url: url)
end
user = User.create_or_find_by!(username: 'admin', password: 'test')
domain = Domain.find_or_create_by!(user_id: user.id, base_url: 'achris.me')
if Visit.count.zero?
  1_000.times.map do
    Visit.create!(
      domain_id: domain.id,
      width: [378, 768, 1024].sample,
      event: 'pageview',
      url: ['https://example.com/', 'https://example.com/homepage', 'https://example.com/blog'].sample,
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
