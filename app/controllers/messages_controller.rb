class MessagesController < ApplicationController
  def index
    load_user
    @messages = current_user.received_messages   
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
     if params[:sort]
      @messages = current_user.lastest_received_messages(5)
    end
    @messages = @messages.order("id").page(params[:page]).per(5)      
  end

  def received
    load_user
    @messages = @user.received_messages
    if params[:sort]
      @messages = current_user.lastest_received_messages(5)
    end
      @messages = @messages.order("id").page(params[:page]).per(5)   
     
  end
  
  def load_user
    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user
    end
  end

   def new
    @messages = Message.new
    @users = User.all
  end

  def create
    @message = Message.new message_params
    @message.sender = current_user
    if @message.save
      flash[:success] = "Message sent !"      
      redirect_to received_messages_path
    else
      flash[:error] = "Error: #{@messages.errors.full_messages.to_sentence}"
      render new_message_path
    end

  end

  def message_params
    params.require(:message).permit(:recipient_id, :body, :subject)
  end

end
