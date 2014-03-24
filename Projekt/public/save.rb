class Examiners::PerformancesController < ApplicationController
  
  respond_to :html, :js, :mobile
  
  
  def index_new
    respond_with 
  end

  # GET /performances/1
  # GET /performances/1.json
  def show
    respond_with
  end

  def new
    @performance = Performance.new()
    # session[:performance_params] ||= {}
    # @performance.current_step = session[:performance_step]
    category = Category.find_by_name CATEGORIES[params['category_name'].to_sym]
    disciplines = Discipline.distinct_category(category.id)
    respond_with @performance do |format|
      format.html { render :locals => {:disciplines => disciplines} }
      format.mobile { render :locals => {:disciplines => disciplines} }
    end
  end

  # GET /performances/1/edit
  def edit
    @performance = Performance.find(params[:id])
  end
  
  def mobForm
    p "SESSION", session
    p "Params", params
    session[:performance_params].deep_merge!(params[:performance]) if params[:performance]
    @performance = Performance.new()
    @performance.current_step = session[:performance_step]
    if params[:back_button]
      @performance.previous_step
    elsif @performance.last_step?
      discipline = Discipline.find(session["performance_params"]["discipline"])
      examiner = Examiner.find(session[:user_id])
      sport_facility = SportFacility.find_by_name(session["performance_params"]["sport_facility"])
      performance_date = get_date session["performance_params"]
      all_athletes = params[:athlete]
    
    else
      @performance.next_step
    end
    session[:performance_step] = @performance.current_step
    if @performance.new_record?
      render "new"
    else
      flash[:notice] = "Oder Save"
      redirect_to @performance
    end
  end

  def create
    discipline = Discipline.find(params[:performance][:discipline])
    examiner = Examiner.find(session[:user_id])
    sport_facility = SportFacility.find_by_name(params[:performance][:sport_facility])
    performance_date = get_date params[:performance]
    all_athletes = params[:athlete]
    
    success_list, fail_list = [], []
    athlete_to_performance, email, performance = {}, nil, nil 
    all_athletes.each do |k, v|
      email = v.split.last.gsub(/[()]/, '')
      a = Athlete.find_by_email(email)
      athlete_to_performance[a] = performance_value(k, params[:athlete_performance], discipline)
    end
    
    athlete_to_performance.each do |athlete, value|
        performance = Performance.new(:date => performance_date, :value => value, :athlete => athlete, :discipline => discipline, :examiner => examiner, :sport_facility => sport_facility)
        if performance.save
          success_list << athlete.full_name
        else
          fail_list << {athlete.full_name => performance.errors.messages.values()}
        end
    end
    flash[:success], flash[:fail] = success_list, fail_list
    p flash[:fail]
    respond_with do |format|
      format.html { render 'result', :locals => {:performance => performance } }
      format.mobile { render 'result', :locals => {:performance => performance } }
    end
  end
  
  def test

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
  
  def athlete_form
    athlete = Athlete.find session[:user_id]
    #if :mobile
     #discipline = Discipline.find(session["performance_params"]["discipline"])
    #else
    discipline = Discipline.find(params[:discipline])
    #end
    respond_with do |format|
      format.js { render 'athlete_form', :layout => false, :locals => {:unit_id => discipline.unit_id, :user_id => athlete.id}}
    end
  end
  
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
  
  def get_date params
    date_hash = params.select { |k, v| not k.scan('date').empty? }
    date_hash.values().join(".").to_date rescue nil
  end
  
  def performance_value index, athlete_performance, discipline
    personal_performance = athlete_performance.select {|k, v| not k.scan(index).empty? }
    if UNIT_TYPES[discipline.unit_id] == UNIT_TYPES[2]  
      min, sec = personal_performance['m'.concat index], personal_performance['s'.concat index]
      min.to_f * 60 + sec.to_f
    else
      personal_performance[index].to_f
    end
  end
  
end
