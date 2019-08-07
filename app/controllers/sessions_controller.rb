class SessionsController < ApplicationController
  skip_before_action :ensure_login, only: [:new, :create]
  def new
    #logger.debug("HERE0.01 @@@@@@@@@@@@@@@@@@@@@@@:#{session[:user_id]}")
    # new.html.erb
  end

  def create
    logger.debug("HERE0.2 @@@@@@@@@@@@@@@@@@@@@@@:#{session[:user_id]}")
    user = User.find_by(username: params[:user][:username])
    password = params[:user][:password]

    if user && user.authenticate(password) then
      session[:user_id] = user.id
      logger.debug("HERE0.3 @@@@@@@@@@@@@@@@@@@@@@@:#{session[:user_id]}")
      redirect_to root_path, notice: "Logged in successfully"
    else
      redirect_to login_path, alert: "Invalid username/password combination"
    end
  end

  def destroy
    reset_session # wipe out session and everything in it
    redirect_to login_path, notice: "You have been logged out"
  end

end
