class UsersController < ApplicationController
  def new
    @users = User.new
  end

  def create
    @users = User.new user_params

    if @users.save
      flash[:success] = "Welcome #{@users.name} !"
      session[:id] = @users.id
      redirect_to user_path(id: @users.id)
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
