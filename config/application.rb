require_relative "boot"

require "rails/all"

require 'dotenv/load'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Faenz
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.autoload_paths << Rails.root.join('lib')

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"e
    # config.eager_load_paths << Rails.root.join("extras")

    config.after_initialize do
      if ENV['FIRST_RUN'] == "true" && User.count.zero? && Rails.env.include?('production')
        username = ENV['ADMIN_USERNAME']
        password = ENV['ADMIN_PASSWORD']
        puts "\n"
        puts '****** Creating a new admin user with the given username and password ******'
        puts "\n"
        User.create!(username: username, password: password, role: 'admin')
      end
    end
  end
end
