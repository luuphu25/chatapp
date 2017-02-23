class HomeController < ApplicationController
  def index
    if current_user
      redirect_to messages_path
    end
  end
end
