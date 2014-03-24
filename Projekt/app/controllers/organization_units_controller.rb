# the organization units controller just returns data for autocompletion
class OrganizationUnitsController < ApplicationController
  
  skip_before_filter :check_login, :only => :autocomplete_organization_unit_name
  
  autocomplete :organization_unit, :name, :full => true
  
end
