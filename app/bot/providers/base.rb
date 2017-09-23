module Providers
  class Base < Facebook::Messenger::Configuration::Providers::Base
    # Verify that the given verify token is valid.
    #
    # verify_token - A String describing the application's verify token.
    #
    # Returns a Boolean representing whether the verify token is valid.


    # Find the right application secret.
    #
    # page_id - An Integer describing a Facebook Page ID.
    #
    # Returns a String describing the application secret.
    def app_secret_for(page_id)
      # bot.find_by(page_id: page_id).app_secret
      ENV.fetch("FB_SECRET")
    end

    # Find the right access token.
    #
    # recipient - A Hash describing the `recipient` attribute of the message coming
    #             from Facebook.
    #
    # Note: The naming of "recipient" can throw you off, but think of it from the
    # perspective of the message: The "recipient" is the page that receives the
    # message.
    #
    # Returns a String describing an access token.
    def access_token_for(recipient)
      # bot.find_by(page_id: recipient['id']).access_token
      ENV.fetch("FB_ACCESS_TOKEN")
    end
  end
end

Facebook::Messenger.configure do |config|
  config.provider = Providers::Base.new
end
