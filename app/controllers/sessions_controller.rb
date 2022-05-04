class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect_to admin_url, alert: "User logged in successfully!"
    else
      redirect_to login_url, alert: "Invalid Username/Password combination"
    end
  end

  def destroy
    session[:user_id] = nil 
    redirect_to store_index_url, alert: "User logout successfully"
  end
end
