require 'spec_helper'

class LoginAthleteTest < ActionController::IntegrationTest  

  describe 'login_athlete' do
    it 'should set values to the session after login' do
      visits '/'
      it { should respond_with(:success) }
      #fill_in 'E-Mail:', :with => 'mario@mario.de'
      #fill_in 'Passwort:', :with => 'webeng12'
      #click_button 'Login'
    end
    
  end

end
