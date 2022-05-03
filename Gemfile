source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

gem 'rails', '~> 7.0.2'

gem 'sprockets-rails'

gem 'rack-cors'

gem 'puma', '~> 5.0'

gem 'jsbundling-rails'

gem 'turbo-rails'

gem 'stimulus-rails'

gem 'cssbundling-rails'

gem 'jbuilder'

gem 'tzinfo-data'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'dotenv', '~> 2.7'

gem 'chartkick', '~> 4.1'

gem 'groupdate', '~> 6.0'

gem 'view_component', '~> 2.49'

gem 'devise', '~> 4.8'

group :production, :production_sqlite do
  gem 'sqlite3', '~> 1.4'
end

group :production_mysql do
  gem 'mysql2', '~> 0.5.3'
end

group :development, :test do
  gem 'benchmark', '~> 0.2.0'
  gem "debug", "~> 1.5"
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.19'
  gem 'rspec-rails', '~> 5.0.0'
end

group :development do
  gem 'web-console'
end
