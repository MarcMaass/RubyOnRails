# This controller is for the member management.
# The district chief can upgrade athletes to examiners
# or downgrade examiners to athletes 
class DistrictChiefs::MembersController < ApplicationController
  respond_to :html, :js
  
  # start page of an district chief
  def index
    respond_with do |format|
      format.html
    end
  end
  
  # search members from the district
  def search_member
    search_params = params[:member].select {|k,v| not v.empty?}
    search_params['email'] = search_params['email'].split().last().gsub(/[()]/, '') if search_params['email']
    search_params['location'] = Location.find_by_postal_code_and_name(*search_params['location'].split()) if search_params['location']
    @members = Athlete.where(search_params)
    respond_with @members do |format|
      format.js
    end
  end
  
  # upgrade member to examiner
  def upgrade_member
    orga_unit = OrganizationUnit.find params[:user][:organization_unit]
    @user = Athlete.find(params[:id])
    @user.type = "Examiner"
    @user.organization_unit = orga_unit
    respond_with @user do |format|
      if @user.save()
        format.js {render 'district_chiefs/members/ajax/change_member', :layout => false}
      end
    end
  end
  
  # downgrade member from examiner to athlete
  def downgrade_member
    @user = Examiner.find(params[:id])
    @user.type = nil
    @user.organization_unit = nil
    @user.save
    respond_with @user do |format|
      if @user.save()
        format.js {render 'district_chiefs/members/ajax/change_member', :layout => false}
      end
    end
  end
end