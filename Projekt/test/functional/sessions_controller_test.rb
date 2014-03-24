require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  context "go to login athletes screen" do
    setup do
      get :athletes
    end
    
    should respond_with(:success)
    should render_template('login_athletes')
  end
  
  context "go to login member screen" do
    setup do
      get :gse
    end
    
    should respond_with(:success)
    should render_template('login_gse')
  end
  
  context "login as athlete" do
    setup do
      @request.env['HTTP_REFERER'] = root_url
      @athlete = Athlete.make!({:gender => Gender.make, :location => Location.make})
      post :create, :login => {:email => @athlete.email, :password => 'webeng12'}
    end
    
    should set_session(:user_id)
    should set_session(:type)
    should redirect_to("/athletes")
  end
  
  context "should not login" do
    setup do
      @request.env['HTTP_REFERER'] = root_url
      @athlete = Athlete.make!({:gender => Gender.make, :location => Location.make})
      post :create, :login => {:email => @athlete.email, :password => 'wrongpass'}
    end
    
    should_not set_session(:user_id)
    should set_the_flash[:error].to("Sie haben einen falschen Benutzernamen oder ein falsches Passwort eingegeben!")
  end
  
  context "should login as examiner" do
    setup do
      @examiner = Examiner.make!({:gender => Gender.make, :location => Location.make})
      post :create, :login => {:email => @examiner.email, :password => 'webeng12'}
    end
    
    should set_session(:user_id)
    should set_session(:type).to("Examiner")
    should redirect_to("/examiners")
  end
end
