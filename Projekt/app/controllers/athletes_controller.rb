#
# This controller class handle all requests and actions affected an athlete.
# 
#
class AthletesController < ApplicationController
  skip_before_filter :check_login, :only => [:registration, :create, :autocomplete_athlete_email]
  respond_to :html, :js
  
  # autocomplete function for autocomplete_fields with the routes 
  autocomplete :athlete, :email, :extra_data => [:last_name, :first_name], :display_value => :full_name_and_email
  
  # displays the starting page for an athlete who is logged in
  def index
    respond_with
  end


  # shows the profile of an athlete
  def show
    @user = Athlete.find session[:user_id]
    
    respond_with @user do |format|
      format.html { render 'common/profile/profile' }
    end
  end
  
  # shows the registration form for new members
  def registration
    @athlete = Athlete.new
    respond_with @athlete do |format|
      format.html { render 'common/registration/register_form', :locals => { :gender => Gender.all } }
    end
  end
  
  # reads the form and creates an athlete to the database
  def create
    location_params = params[:athlete][:location].split()
    postal_code, name = location_params
    params[:athlete][:location] = Location.find_by_postal_code_and_name(postal_code, name)
    organization_units = OrganizationUnit.where(:name => params[:organization_units].values()) 
    
    @athlete = Athlete.new(params[:athlete])
    respond_with @athlete do |format|
      if @athlete.save()
        @athlete.organization_units << organization_units
        format.html { redirect_to root_path, :notice => 'Ihre Anmeldung war erfolgreich. Sie koennen sich nun einloggen!' }
      else
        format.html { render 'common/registration/register_form', :locals => { :gender => Gender.all } }
      end
    end
  end
  
  # returns the adress form. this method handles an ajax call
  def address_form
    @user = Athlete.find session[:user_id]
    respond_with @user do |format|
      format.js { render 'common/profile/ajax/change_address', :locals => { :l => @user.location }, :layout => false }
    end
  end
  
  # handles a put request. updating the whole address data
  def update_location
    @user = Athlete.find(session[:user_id])

    if params[:location]
      # split the information of the location form field (NNNN  LocationName)
      postal_code, location_name = params[:location][:postal_code_and_name].split
      location = Location.find_by_postal_code_and_name(postal_code, location_name)
    end
    params[:user][:location] = location
    respond_with @user do |format|
      if @user.update_attributes(params[:user])
        format.js { render 'common/profile/ajax/contact_data', :layout => false }
      else
        p @user.errors.messages
        format.js { render 'common/profile/ajax/error', :layout => false}
      end
    end
  end
  
  # handels an ajax request and renders an password form
  def password_form
    @user = Athlete.find(session[:user_id])
    respond_with @user do |format|
      format.js { render 'common/profile/ajax/change_password', :layout => false }
    end
  end
  
  # updates the user password
  def update_password
    @user = Athlete.find(session[:user_id])
    params[:user] = {}
    if params[:password]
      password, confirmation = params[:password][:password], params[:password][:password_confirmation]  
    end
    respond_with do |format|
      # check if the old password was correct
      if @user.authenticate(params[:password][:old_password])
        params[:user][:password] = password
        params[:user][:password_confirmation] = confirmation
        if @user.update_attributes(params[:user])
          format.js { render 'common/profile/ajax/update_password', :layout => false }
        else
          format.js { render 'common/profile/ajax/error', :layout => false } 
        end
      else
        @user.errors.add(:password,'Das alte Passwort ist falsch!')
        format.js { render 'common/profile/ajax/error', :layout => false }
      end
    end
  end
  
  # renders an organization unit form after an ajax call
  def orga_unit_form
    @user = Athlete.find session[:user_id]
    respond_with @user do |format|
      format.js { render 'common/profile/ajax/add_orga_unit_form', :layout => false }        
    end
  end
  
  # add an organization unit
  def add_orga_unit
    @user = Athlete.find session[:user_id]
    old_orga_count = @user.organization_units.count 
    if params[:organization_unit]
      orgas = getOrganizationUnits params[:organization_unit]
      orgas.each do |o|
        @user.organization_units << o if not @user.organization_units.include? o 
      end
      new_orga_count = @user.organization_units.count
    end
    
    respond_with @user do |format|
        format.js { render 'common/profile/ajax/show_orga_units', :layout => false}
    end
  end
  
  # removes the connection between an athlete and an organization unit
  def delete_orga_unit
    @user = Athlete.find session[:user_id]
    # delete an orga_unit
    organization_unit = OrganizationUnit.find params[:id]
    @user.organization_units.delete organization_unit
    respond_with @user do |format|
      format.js { render 'common/profile/ajax/show_orga_units', :layout => false }
    end
  end
  
  # returns the picture form for the profile
  def picture_form
    @user = Athlete.new
    respond_with @user do |format|
      format.js { render 'common/profile/ajax/picture_form', :layout => false}
    end
  end
  
  # updates the picture
  def update_picture
    @user = Athlete.find session[:user_id]
    respond_with @user do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to :action => :show }
      end
    end
  end
  
  # deletes the picture
  def delete_picture
    @user = Athlete.find session[:user_id]
    @user.picture.destroy()
    @user.save()
    respond_with @user do |format|
      format.js { render :layout => false }
    end
  end
end