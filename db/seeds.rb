return if Rails.env != 'development'

user = User.find_by(username: ENV['ADMIN_USERNAME'])
user ||= User.create!(username: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD'])

domain = Domain.find_or_create_by!(user_id: user.id, base_url: 'example.com')

if Visit.count.zero?
  ips_pool = 500.times.map { IpDigester.call(ip: Faker::Internet.ip_v4_address) }
  referrers_pool = [
    'github.com',
    'google.com',
    'twitter.com',
    'youtube.com',
    'bing.com',
    'facebook.com',
    'instagram.com'
  ]
  urls_pool = [
    '',
    '/homepage',
    '/blog',
    '/about',
    '/contact',
    '/privacy',
    '/terms',
    *10.times.map(&:to_s)
  ].map { |s| "#{domain.base_url}#{s}" }

  1_000.times.map do
    Visit.create!(
      domain_id: domain.id,
      width: [378, 768, 1024].sample,
      event: 'pageview',
      url: urls_pool.sample,
      referrer: referrers_pool.sample,
      ip: ips_pool.sample, # so we can simulate bounce rate
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
