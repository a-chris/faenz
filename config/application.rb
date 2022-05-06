require_relative "boot"

require "rails/all"

if Rails.env.development?
  require 'dotenv/load'
  Dotenv.load('.env.development')
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Faenz
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.autoload_paths << Rails.root.join('lib')

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"e
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
