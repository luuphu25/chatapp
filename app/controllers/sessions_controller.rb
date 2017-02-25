class SessionsController < ApplicationController
  def new
  end
  def callback
    if user = User.from_omniauth(env["omniauth.auth"])
      flash[:success] = "Welcome #{@user.name} !"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      if @user.authenticate(params[:password])
        flash[:success] = "Welcome #{@user.name} !"
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash[:error] = "Wrong password!" 
        render 'new'
      end
    else
      flash[:error] = "User not found !"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out!"
    redirect_to root_path
  end

end
