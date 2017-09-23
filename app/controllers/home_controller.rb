class HomeController < ApplicationController
  def index
  end

  def callback
    redirect_to root_path
  end
end
