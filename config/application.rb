require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Amazon
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    #Configurations for ActiveJob to use DelayedJob 👇
    config.active_job.queue_adapter = :delayed_job

    #Configurations for CORS to SPA 
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins('127.0.0.1:5500', 'localhost:5500', 'localhost:7777', 'localhost:8002')
        resource(
          "/api/*",
          headers: :any,
          credentials: true,
          methods: [:get, :post, :delete, :patch, :put, :options]
        )
      end
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.generators do |g|
      #Don't create helper files when using 'rails generator'
      #--no-helper
      g.helper = false
      #Don't create js & css files when using 'rails generator'
      #--no-assets
      g.assets = false
    end
  end
end
