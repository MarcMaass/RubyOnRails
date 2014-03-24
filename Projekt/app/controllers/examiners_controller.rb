class ExaminersController < ApplicationController
  respond_to :html, :mobile
  # GET /examiners
  # GET /examiners.json
  
  
  def index
    session[:performance_step] = session[:performance_params] = nil
    respond_with
  end

  def show
    @user = Athlete.find session[:user_id]
    respond_with @user do |format|
      format.html { render 'common/profile' }
    end
  end
  
  def sesremove
    session[:performance_step] = session[:performance_params] = nil
  end

  # PUT /examiners/1
  # PUT /examiners/1.json
  def update
    @examiner = Examiner.find(params[:id])

    respond_to do |format|
      if @examiner.update_attributes(params[:examiner])
        format.html { redirect_to @examiner, notice: 'Examiner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @examiner.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
