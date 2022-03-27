FactoryBot.define do
  factory :user do
    username { "jon_doe" }
    role { 'admin' }
  end

  factory :domain do
    association :user

    factory :domain_github do
      base_url { 'github.com' }
      icon { 'https://github.com/favicon.ico' }
    end

    factory :domain_achris do
      base_url { 'achris.me' }
      icon { 'https://achris.me/favicon.ico' }
    end
  end

  factory :visit do
    sequence :url do |i|
      "https://github.com/page_#{i}"
    end
    sequence :time_at do |i|
      Time.now - i.to_i.send(:hours)
    end
    event { 'pageview' }
    width { 1440 }
    ip { '0.0.0.0' }
    geo { {} }

    trait :random_width do
      [378, 768, 1024, 1440].sample
    end
  end
end