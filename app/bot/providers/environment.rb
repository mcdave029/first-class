module Providers
  class Environment < Facebook::Messenger::Configuration::Providers::Environment
    def valid_verify_token?(verify_token)
      verify_token == ENV['FB_VERIFY_TOKEN']
    end

    def app_secret_for(*)
      ENV['FB_SECRET']
    end

    def access_token_for(*)
      ENV['FB_ACCESS_TOKEN']
    end
  end
end

Facebook::Messenger.configure do |config|
  config.provider = Providers::Environment.new
end
