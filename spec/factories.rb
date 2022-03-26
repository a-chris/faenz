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
end