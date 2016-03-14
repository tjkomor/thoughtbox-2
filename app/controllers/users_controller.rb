class UsersController < ApplicationController

  def create
    if params[:user][:confirmation] == params[:user][:password]
      @user = User.new(user_params)
      create_user
    else
      flash.now[:errors] = ["Confirmation does not match password"]
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def create_user
    if @user.save
      session[:user_id] = @user.id
      redirect_to links_path
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
end
