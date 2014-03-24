# This controller manages the session after the login
class SessionsController < ApplicationController
  respond_to :html, :mobile
  skip_before_filter :check_login
  helper_method :login_athlete, :login_dosb_member
  
  def athletes
    respond_with do |format|
      format.html {render 'login_athletes'}
      format.mobile {render 'login_gse'}
    end
  end
  
  def gse
    render 'login_gse'
  end
  
  def create
    if params[:login].has_key?(:email) && params[:login].has_key?(:password)
      login_email, login_pass = params[:login][:email], params[:login][:password]  
    end
    user = Athlete.find_by_email(login_email)
    response_path = request.referer
    if user && user.authenticate(login_pass)
      if !mobile_device? and request.referer == root_url
        response_path = athletes_path
        user_role = Athlete.to_s
      else
        response_path, user_role = login_dosb_member_with user
      end
      if user_role
        session[:user_id] = user.id
        session[:type] = user_role
      end
    else
      flash[:error_title] = "Fehler beim Anmeldevorgang!"
      flash[:error] = "Sie haben einen falschen Benutzernamen oder ein falsches Passwort eingegeben!"
    end
    redirect_to response_path  
  end
  
  def destroy
    session.each_key do |key|
      session[key] = nil
    end
    redirect_to root_url, :notice => "Sie haben sich erfolgreich abgemeldet."
  end
  
  protected
  
  def login_dosb_member_with(user)
    case user.type
    when 'DistrictChief'
      [district_chiefs_path, DistrictChief.to_s]
    when 'Examiner'
      [examiners_path, Examiner.to_s]
    else
      flash[:error_title] = "Fehler beim Anmeldevorgang!"
      flash[:error] = "Sie haben einen falschen Benutzernamen oder ein falsches Passwort eingegeben!"
      [request.referer, nil]
    end
  end
end