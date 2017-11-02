class HomeController < ApplicationController
  def index
  end

  def callback
    redirect_to root_path
  end

  def set_messenger_profile
    Facebook::Messenger::Profile.set({
      get_started: {
        payload: 'GET_STARTED_PAYLOAD'
      }
    }, access_token: ENV['FB_ACCESS_TOKEN'])

    render :nothing => true
  end
end
