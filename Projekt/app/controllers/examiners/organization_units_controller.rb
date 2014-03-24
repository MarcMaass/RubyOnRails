# This is the organization units controller for examiners
# Examiners can edit their organization unit data and add
# Sport Facilities to it.

class Examiners::OrganizationUnitsController < ApplicationController
  respond_to :html, :js
  
  # show organization_unit of the examiner
  def show
    examiner = Examiner.find(session[:user_id])
    
    @organization_unit = OrganizationUnit.find(examiner.organization_unit.id)

    respond_with @organization_unit do |format|
      format.html 
    end
  end
  
  # edit form for organization_unit
  def edit
    @organization_unit = OrganizationUnit.find(params[:id])
    respond_with @organization_unit do |format|
      format.js
    end
  end
  
  # update the organization_unit 
  def update
    @organization_unit = OrganizationUnit.find params[:id]
    location_input = params[:location].delete(:postal_code_and_name)
    location_record = Location.fetch_postal_code_and_name location_input.split()
    params[:organization_unit][:location] = location_record.first()
    respond_with @organization_unit do |format|
      if @organization_unit.update_attributes params[:organization_unit]
        format.js
      else
        format.js { render 'error' }
      end
    end
  end
  
  # render form for a new sport facility
  def new_sport_facility
    @sport_facility = SportFacility.new
    @organization_unit = Examiner.find(session[:user_id]).organization_unit_id
    respond_with [@sport_facility, @organization_unit] do |format|
      format.js
    end
  end
  
  # create a new sport facility
  def create_sport_facility
    @organization_unit = OrganizationUnit.find params[:id]
    # get postal code and location name from parameters
    location_params = params[:location].delete(:postal_code_and_name)
    postal_code, location_name = location_params.split()
    sport_facility_name = params[:sport_facility][:name]
    params[:sport_facility][:location] = Location.find_by_postal_code(postal_code)
    location_id = params[:sport_facility][:location].id
    # check if there is a sport facility in that location
    @sport_facility = SportFacility.find_by_location_id_and_name(location_id, sport_facility_name)
    # if there is no record, create a new one
    @sport_facility = SportFacility.new params[:sport_facility] unless @sport_facility
    respond_with do |format|
      unless @sport_facility.id
        # if it is a new sport facility, then create it and bind it to organization_unit
        if @sport_facility.save
          @organization_unit.sport_facilities << @sport_facility
          format.js
        else
          # not valid!
        end
      else
        # otherwise just bind it to the organization unit
      end
    end
  end
  
  def show_sport_facility
    # zeige details einer sportstätte
  end
  
  def edit_sport_facility
    # editiere einzelne details einer sportstätte
  end  
  
  def remove_sport_facility
    # lösche sportstätte  
  end
  
end
