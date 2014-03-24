# The main action of the controller is the observation
# of performances of an Athlete.
# An Athlete can select the years and filter the results
class Athletes::PerformancesController < ApplicationController
  respond_to :html
  
  def index 
    # set the year of the performances. if he has not any in this year get the current
    param_year = if params[:date]
                   Date.new params[:date][:year].to_i, 1, 1
                 else 
                   Date.today.beginning_of_year
                 end
    date_range = param_year..(param_year.next_year-1)
    athlete = Athlete.find(session[:user_id])
    # get all performances of the selected year
    @performances, maxima, @rejected = *get_athletes_performances(athlete, date_range)
    # this is for the form at the index page
    start_year = athlete.performances.minimum('date').year if athlete.performances.minimum('date') 
    start_year = Date.today.year unless start_year
    end_year = Date.today.year
    respond_with [@performances, @rejected] do |format|
      format.html { render 'index', :locals => { :start_year => start_year, :end_year => end_year, :maxima => maxima } }
    end 
  end
  
  private
  
  # returns the performances of the athlete in a map.
  # furthermore the maxima of every category is saved.
  def get_athletes_performances(athlete, date_range)
    result, maxima = {}, {}
    athlete_performances = Performance.where(:athlete_id => athlete.id, :date => date_range, :inspected => true)
    unless athlete_performances.empty?
      performance_to_medal, category_name = nil, nil
      athlete_performances.each do |performance| 
         category_name = performance.discipline.category.name
         result[category_name] = {} unless result[category_name]
         performance_to_medal = calc_medal_of(athlete, performance)
         if performance_to_medal
          result[category_name].store(*performance_to_medal)
          max = maximum_of_category(maxima.fetch(category_name,Medal.find_by_points(0)), performance_to_medal)
          maxima.store(category_name, max)
         end
      end
    end
    [result, maxima, Performance.where('athlete_id = ? AND date IN (?) AND district_chief_id IS NOT NULL AND inspected = false', athlete.id, date_range)]
  end
  
  # calculates the medal between a performance and an athlete
  def calc_medal_of(athlete, performance)
    age_of_athlete, result = (Date.today.year - athlete.birthday.year),nil
    age_range = AgeRange.find_by_age(age_of_athlete).first()
    discipline_age = DisciplineAge.find_by_discipline_id_and_age_range_id(performance.discipline_id, age_range.id)
    required_performances = RequiredPerformance.where(:discipline_age_id => discipline_age.id).order(:medal_id)
    #if it is not a discipline of 'Turnen' then calculate it
    unless performance.discipline.name == 'Turnen'
      bronze, silver, gold = required_performances
      result = case performance.discipline.unit_id
      when 2,4
        # time performances
        if performance.value > bronze.value
          Medal.find(1)
        elsif performance.value > silver.value and performance.value <= bronze.value 
          bronze.medal
        elsif performance.value > gold.value and performance.value <= silver.value 
          silver.medal
        else
          gold.medal
        end
      else
        # others performances (no time performances)
        if performance.value < bronze.value
          Medal.find(1)
        elsif bronze.value <= performance.value and performance.value < silver.value
          bronze.medal
        elsif silver.value <= performance.value and performance.value < gold.value
          silver.medal
        else
          gold.medal
        end
      end
    else
      # TODO: handle Turnen...
    end
    return [performance, result] if result
    return nil
  end
  
  # returns the maximum of a category
  def maximum_of_category(actual_max, performance_to_medal)
    performance, medal = *performance_to_medal
    if medal.points >= actual_max.points 
      actual_max = medal
    end
    actual_max
  end
  
end
