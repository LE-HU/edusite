require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Edusite
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # rails-erd
    if Rails.env.development?
      def eager_load!
        Zeitwerk::Loader.eager_load_all
      end
    end

    #video previews for action_text
    config.after_initialize do
      ActionText::ContentHelper.allowed_attributes.add "style"
      ActionText::ContentHelper.allowed_attributes.add "controls"

      ActionText::ContentHelper.allowed_tags.add "video"
      ActionText::ContentHelper.allowed_tags.add "audio"
      ActionText::ContentHelper.allowed_tags.add "source"
    end
  end
end
