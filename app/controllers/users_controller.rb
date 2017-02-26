class UsersController < ApplicationController
  
  def index
    @users = User.order("id").page(params[:page]).per(4)
    @friendships = Friendship.all
  end

  def new
    @users = User.new
  end

  def create
    @users = User.new user_params

    if @users.save
      flash[:success] = "Welcome #{@users.name} !"
      session[:id] = @users.id
      redirect_to received_messages_path
    else
      flash[:error] = "Error: #{@users.errors.full_messages.to_sentence}"
      render new_user_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
