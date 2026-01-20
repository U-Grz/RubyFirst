class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Log in the user immediately after signup
      session[:user_id] = @user.id
      redirect_to products_path, notice: "Welcome, #{@user.email}!"
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
