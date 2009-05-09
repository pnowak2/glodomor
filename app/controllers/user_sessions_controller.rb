class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default root_path
    else
      flash[:notice] = "Couldn't log you in!"
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    session[:cart] = nil
    session[:return_to] = nil
    flash[:notice] = "Logout successful!"
    redirect_to root_path
  end
end
