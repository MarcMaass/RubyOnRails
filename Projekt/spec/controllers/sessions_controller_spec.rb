require 'spec_helper'

# This is a specification to check the routing of the
# sessions controller. The login test should be available
# in spec/integration
describe SessionsController do
  
  # Just go the the root url; this is the login page for athletes
  describe 'root' do
    it {
      should route(:get, root_path).to(:action => :athletes)
      get :athletes
      should respond_with(:success)
      should render_template('login_athletes')
    }
  end
  
  # Switch to the login-interface of members
  describe 'login_gse' do
    it {
      should route(:get, '/dosb').to(:action => :gse)
      get :gse
      should respond_with(:success)
      should render_template('login_gse')
    }
  end
  
end
