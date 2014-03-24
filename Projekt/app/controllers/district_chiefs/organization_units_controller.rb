# OrganizationUnits Controller for DistrictChiefs
# All DistrictChiefs are 
class DistrictChiefs::OrganizationUnitsController < ApplicationController
  respond_to :html, :js
  
  def index
    
  end
  
  # show form to create a new organization unit
  def new
    @organization_unit = OrganizationUnit.new
    respond_with @organization_unit
  end
  
  # create a organization unit
  def create
    creation_params = params[:organization_unit].select {|k,v| not v.empty?}
    creation_params['location'] = Location.find_by_postal_code_and_name(*(creation_params['location'].split())) if creation_params['location']
    @organization_unit = OrganizationUnit.new(@organization_unit)
    respond_with @organization_unit do |format|
      if @organization_unit.save()
        format.html { render  }
      else
        format.html 
      end
    end
  end
  
  def update
    
  end
  
  def search_organization_unit
    district_chief = DistrictChief.find(session[:user_id])
    locations = Location.where(:district_id => District.where(:district_chief_id => district_chief.id))
    @organization_units = OrganizationUnit.where('name ILIKE ? AND location_id IN (?)', "%#{params[:organization_unit][:name]}%", locations)
    p @organization_units
    respond_with @organization_units do |format|
      format.js
    end
  end
  
  def destroy
    @organization_unit = OrganizationUnit.find(params[:id])
  end
  
end
