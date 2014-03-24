class DistrictChiefsController < ApplicationController
  respond_to :html
  
  def index
    respond_with
  end

  def show
    @user = Athlete.find session[:user_id]
    respond_with @user do |format|
      format.html { render 'common/profile' }
    end
  end

  # GET /district_chiefs/new
  # GET /district_chiefs/new.json
  def new
    @district_chief = DistrictChief.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @district_chief }
    end
  end

  def update
    @district_chief = DistrictChief.find(params[:id])

    respond_to do |format|
      if @district_chief.update_attributes(params[:district_chief])
        format.html { redirect_to @district_chief, notice: 'District chief was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @district_chief.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /district_chiefs/1
  # DELETE /district_chiefs/1.json
  def destroy
    @district_chief = DistrictChief.find(params[:id])
    @district_chief.destroy

    respond_to do |format|
      format.html { redirect_to district_chiefs_url }
      format.json { head :no_content }
    end
  end
  
  def member
    respond_with 
  end
end
