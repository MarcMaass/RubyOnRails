# The DisciplinesController is used to 

class DisciplinesController < ApplicationController
  
  respond_to :html, :js
  
  # render the index site, there is a choice of the category
  def index
    render 
  end
  
  # get the filter form for disciplines
  def index_discipline
    category_name = params[:category].to_sym
    @discipline = Discipline.new
    @disciplines = Discipline.distinct_category(CATEGORY_ID[category_name])
    respond_with @disciplines do |format|
      format.html
    end
  end

  def show
    @required_performances = {}
    tempLis, @unit = [], nil
    discipline_name = params[:discipline][:name]
    @disciplines = Discipline.where(:name => discipline_name)
    @disciplines.each do |discipline|
      tempLis = []
      @unit = discipline.unit unless @unit
      discipline_age = DisciplineAge.where(:discipline_id => discipline).order("age_range_id")
      discipline_age.each do |da|
        tempLis << ["#{da.age_range.min_age} - #{da.age_range.max_age}", RequiredPerformance.where(:discipline_age_id => da)]
      end
      @required_performances.store(discipline.gender, tempLis)
    end
    respond_with @required_performances do |format|
      format.js
    end
  end
  
end
