class ApplicationController < ActionController::Base
  protect_from_forgery  
  
  helper ApplicationHelper, PathHelper
  helper_method :check_login, :logged_in?
  before_filter :check_login, :prepare_for_mobile
  
  protected
  
  def check_login
    unless logged_in?
      flash[:error] = "Anmeldung erforderlich!"
      redirect_to root_url
    end
  end
  
  def logged_in?
    session[:user_id]
  end
  
  private
  
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?
  
  def prepare_for_mobile
    if request.user_agent =~ /Mobile|webOS/ and not request.format == "text/javascript"
      request.format = :mobile
    end     
  end
end
