require 'spec_helper'

# These tests are for the functions in the AthletesController
describe AthletesController do
  
  describe 'go to registration' do
    it {
      should route(:get, '/register').to(:action => :registration)
      get :registration
      should respond_with(:success)
      should assign_to(:athlete).with_kind_of(Athlete)
      should render_template('common/registration/register_form')
    }
  end
 
  describe 'should register a new user' do
    params = {
      :athlete => {
        :email => "karl@karl.de", 
        :last_name => "Karlsson", 
        :first_name => "Karl", :birthday => "08.03.1980".to_date, 
        :street => "Musterstra\u00DFe", 
        :house_number => 12, 
        :phone => "0611 65432", 
        :password => '12345678', 
        :password_confirmation => '12345678',
        :gender_id => Gender.find_by_sex('m')  
      },
      :location => { 
        :postal_code_and_name => '65207 Wiesbaden'
      },
      :organization_units => {}
    }
    user_count = Athlete.all().count()
    
    it {
      post :create, parameters = params
      should respond_with(:success)
      assert_equal((user_count + 1), Athlete.all().count())
    }
    
  end 
end
