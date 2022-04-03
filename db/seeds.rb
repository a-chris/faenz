return if Rails.env != 'development'

user = User.find_by(username: ENV['ADMIN_USERNAME'])
user ||= User.create!(username: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD'])

domain = Domain.find_or_create_by!(user_id: user.id, base_url: 'example.com')

if Visit.count.zero?
  1_000.times.map do
    Visit.create!(
      domain_id: domain.id,
      width: [378, 768, 1024].sample,
      event: 'pageview',
      url: ['',
            '/homepage',
            '/blog',
            '/about',
            '/contact',
            '/privacy',
            '/terms',
            *10.times.map(&:to_s)].map { |s| "#{domain.base_url}#{s}" }.sample,
      referrer: ['github.com', 'google.com', 'twitter.com', 'youtube.com', 'bing.com', 'facebook.com', 'instagram.com'].sample,
      ip: Faker::Internet.public_ip_v4_address,
      geo: {
        lat: Faker::Address.latitude,
        lng: Faker::Address.longitude,
        country: Faker::Address.country,
        country_code: Faker::Address.country_code,
        region: Faker::Address.state,
        city: Faker::Address.city
      },
      time_at: rand(0..120).hours.ago
    )
  end
end
