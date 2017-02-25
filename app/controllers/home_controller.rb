class HomeController < ApplicationController
  def index
    if current_user
      redirect_to received_messages_path
    end
  end
end
