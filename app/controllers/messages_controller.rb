class MessagesController < ApplicationController
  def index
    @messages = current_user.received_messages
  end
end
