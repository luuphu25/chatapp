class MessagesController < ApplicationController
  def index
    @messages = current_user.received_messages
    if params[:sort]
      @messages = current_user.lastest_received_messages(10)
    end
  end

  def show
    @message= Message.where(recipient: current_user).find params[:id]       
    
    if @message.read_at == nil 
      @message.mark_as_read!
    end
  end

  def sent
    load_user
    @messages = @user.sent_messages
  end

  def received
    load_user
    @messages = @user.received_messages
  end
  
  def load_user
    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user
    end
  end

end
