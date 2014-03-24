# This Controller handles the functionality to create the
# performances of an athlete
class Examiners::PerformancesController < ApplicationController  
  respond_to :html, :js, :mobile
  
  # go to the choice screen
  def index_new
    respond_with 
  end

  # should show the concrete performance for editing
  def show
    respond_with
  end

  # get the form of a new performance
  def new
    category_sym = params['category_name'].to_sym
    @performance = Performance.new()
    if params["format"] == "mobile"
      session[:performance_params] ||= {}
      @performance = Performance.new()
      @performance.current_step = session[:performance_step]
    end
    @disciplines = Discipline.distinct_category(CATEGORY_ID[category_sym])
    respond_with @performance do |format|
      format.html { render :locals => {:disciplines => @disciplines} }
      format.mobile { render :locals => {:disciplines => @disciplines} }
    end
  end

  # edit some performances not implemented yet...
  def edit
    @performance = Performance.find(params[:id])
  end
  
  # get the mobile form 
  def mobForm
    session[:performance_params].deep_merge!(params[:performance]) if params[:performance]
    @performance = Performance.new()
    @performance.current_step = session[:performance_step]
    @performance.next_step
    session[:performance_step] = @performance.current_step
    if @performance.new_record? and not @performance.last_step?
      render "new" 
    elsif @performance.last_step?
      discipline = Discipline.find(session["performance_params"]["discipline"])
      sport_facility = SportFacility.find_by_name(session["performance_params"]["sport_facility"])
      performance_date = get_date session["performance_params"] 
      datasave(discipline,sport_facility,performance_date)
    end
  end
    
  # if the format is a mobile phone, the multi step form is activated
  # otherwise it returns the single step form
  def create
    if params["format"] == "mobile"
      mobForm
    else
      discipline = Discipline.find(params[:performance][:discipline])
      sport_facility = SportFacility.find_by_name(params[:performance][:sport_facility])
      performance_date = get_date params[:performance]
      datasave(discipline,sport_facility,performance_date)
    end
  end
  
  # saves the data of a performance
  # if everything is okay, then every record will be saved
  # otherwise the record will be discarded
  def datasave(discipline,sport_facility,performance_date)
    examiner = Examiner.find(session[:user_id])
    all_athletes = params[:athlete]
    
    success_list, fail_list = [], []
    athlete_to_performance, email, performance = {}, nil, nil 
    all_athletes.each do |k, v|
      email = v.split.last.gsub(/[()]/, '')
      a = Athlete.find_by_email(email)
      unless a.activated
        # if user is not activate yet, activate him
        a.activated = true
        a.save()
      end
      athlete_to_performance[a] = performance_value(k, params[:athlete_performance], discipline)
    end
    athlete_to_performance.each do |athlete, value|
      discipline_of_athlete = Discipline.find_by_name_and_gender_id(discipline.name, athlete.gender)
      performance = Performance.new(:date => performance_date, :value => value, :athlete => athlete, :discipline => discipline_of_athlete, :examiner => examiner, :sport_facility => sport_facility)
      if performance.save
        success_list << athlete.full_name
      else
        fail_list << {athlete.full_name => performance.errors.messages.values()}
      end
    end
    flash[:success], flash[:fail] = success_list, fail_list
    session[:performance_step] = session[:performance_params] = nil
    respond_with do |format|
      format.html { render 'result', :locals => {:performance => performance } }
      format.mobile { render 'result', :locals => {:performance => performance } }
    end
  end
  
  # PUT /performances/1
  # PUT /performances/1.json
  def update
    @performance = Performance.find(params[:id])

    respond_to do |format|
      if @performance.update_attributes(params[:performance])
        format.html { redirect_to @performance, notice: 'Performance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @performance.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # returns the form for the performance dynamically
  # look at getUnitFormElements method in performances_helper.rb
  def athlete_form
    athlete = Athlete.find session[:user_id]
    if mobile_device?
      discipline = Discipline.find(session["performance_params"]["discipline"])
    else
      discipline = Discipline.find(params[:discipline])
    end
    respond_with do |format|
      if mobile_device?
        format.js { render 'athlete_mobile_form', :layout => false, :locals => {:unit_id => discipline.unit_id, :user_id => athlete.id}}
      else
        format.js { render 'athlete_form', :layout => false, :locals => {:unit_id => discipline.unit_id, :user_id => athlete.id}}
      end
    end
  end
  
  # search for performances in the edit view of performances
  def search_performance
    search_params = params[:search_performance].select { |k,v| not v.empty? }
    search_params['athlete'] = Athlete.find_by_email(search_params.delete('email').split.last.gsub(/[()]/, '')) if search_params['email']
    search_params['sport_facility'] = SportFacility.find_by_name(search_params['sport_facility']) if search_params['sport_facility']
    search_params['date'] = get_date(params[:search_performance]) if search_params['date']
    @performances = Performance.where(search_params)
    respond_with @performances do |format|
      format.js 
    end 
  end
  
  private
  
  def is_integer? str
    true if Integer(str) rescue false
  end
  
  # get a date from the incomming params
  def get_date params
    date_hash = params.select { |k, v| not k.scan('date').empty? }
    date_hash.values().join(".").to_date rescue nil
  end
  
  # get the correct performances value
  def performance_value index, athlete_performance, discipline
    personal_performance = athlete_performance.select {|k, v| not k.scan(index).empty? }
    if UNIT_TYPES[discipline.unit_id] == UNIT_TYPES[2]  
      min, sec = personal_performance['m'.concat index], personal_performance['s'.concat index]
      min.to_f * 60 + sec.to_f
    else
      personal_performance[index].gsub(/,/,'.').to_f
    end
  end
end
