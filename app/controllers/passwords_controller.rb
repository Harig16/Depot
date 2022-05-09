class PasswordsController < ApplicationController

  before_action :current_user

  def edit
  end

  def update
    respond_to do |format|
      if authorization && @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
        format.html { redirect_to user_path(@user), notice: "Password Updated successfully" }
      else
        flash[:alert] = "Password Incorrect!!!" 
        format.html { redirect_to edit_password_path } 
      end
    end
  end

  private 

    def current_user
      @user = User.find_by(id: session[:user_id])
    end

    def authorization
      @user && @user.authenticate(params[:current_password])
    end

    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
end