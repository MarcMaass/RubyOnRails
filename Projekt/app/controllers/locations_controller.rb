
# The locations Controller just returns data for autocompletion
class LocationsController < ApplicationController
  
  skip_before_filter :check_login, :only => :autocomplete_location_postal_code
  
  autocomplete :location, :postal_code, :full => true, :extra_data => [:name], :display_value => :postal_code_and_name
end