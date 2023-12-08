source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '~> 7.1'

gem 'sprockets-rails'

gem 'rack-cors'

gem 'puma', '~> 6.0'

gem 'importmap-rails'

gem 'dartsass-rails', '~> 0'

gem 'turbo-rails'

gem 'tzinfo-data'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'chartkick', '~> 4.1'

gem 'groupdate', '~> 6.0'

gem 'view_component', '~> 3.0'

gem 'devise', '~> 4.8'

group :production, :production_sqlite do
  gem 'sqlite3', '~> 1.4'
end

group :production_mysql do
  # gem 'mysql2', '~> 0.5.3'
end

group :development, :test do
  gem 'benchmark', '~> 0.2'
  gem 'debug', '~> 1.5'
  gem 'dotenv', '~> 2.7'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.19'
  gem 'rspec_junit_formatter', '~> 0.5'
  gem 'rspec-rails'
end

group :development do
  gem 'rails_live_reload'
  gem 'web-console'
end

gem "irb", "~> 1.10"
