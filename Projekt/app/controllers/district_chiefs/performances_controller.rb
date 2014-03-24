class DistrictChiefs::PerformancesController < ApplicationController
  respond_to :html
  
  
  def index
    @district = District.find_by_district_chief_id(DistrictChief.find(session[:user_id]))
    @performances = Performance.find_uninspected_and_in_district(@district)
    @unit = @performances.first.discipline.unit
    respond_with [@district, @unit, @performances] do |format|
      format.html
    end
  end
  
  def update
    district_chief = DistrictChief.find(session[:user_id])
    @performance = Performance.find(params[:id])
    @performance.district_chief = district_chief
    if params[:choice] == 'accept'
      # inspected means accepted
      @performance.inspected = true
    else
      @performance.inspected = false
    end
    respond_with @performance do |format|
      if @performance.save()
        format.js {render :layout => false}
      end
    end
  end
  
end
