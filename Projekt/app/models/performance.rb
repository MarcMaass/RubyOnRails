class Performance < ActiveRecord::Base
  scope :find_uninspected_and_in_district, lambda {|district|
    sport_facilities = SportFacility.where(:location_id => Location.where(:district_id => district))
    where(:sport_facility_id => sport_facilities, :district_chief_id => nil, :inspected => false)
  }
  
	belongs_to :sport_facility
  belongs_to :athlete
  belongs_to :examiner
  belongs_to :district_chief
  belongs_to :discipline
  attr_accessible :date, :value ,:athlete, :discipline, :examiner, :district_chief, :sport_facility, :inspected
  attr_writer :current_step
  # custom validators
  validate :should_valid_athlete
  validate :should_valid_age
  validate :should_valid_date
  validate :should_valid_gender
  # validators
  validates :value, :presence => true, :numericality => { :greater_than_or_equal_to => 0}  
  validates :sport_facility, :presence => true
  
  # Show current sept in Multistepform
  def current_step
    @current_step || steps.first
  end
  
  # Multistepformsitenames
  def steps
    %w[dicipline data show]
  end
  # change sites
  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def first_step?
    current_step == steps.first
  end
  
  def last_step?
    current_step == steps.last
  end
  
  def getCategory
    discipline.category.name
  end
  
  def getCategoryID
    discipline.category_id
  end
  
  protected
  # Valid if User habe correct rights to do changes
  def should_valid_athlete
    if not athlete
      errors.add(:performance, 'Es wurde kein(e) Sportler(in) gefunden.')
    elsif not examiner
      errors.add(:performance, 'Es wurde kein(e) Pruefer(in) gefunden.')
    elsif athlete == examiner
      errors.add(:performance, 'Pruefer duerfen keine eigenen Leistungen eingeben.')
    end
  end
  
  # Valid Date
  def should_valid_date
    begin
      if date.future?
        errors.add(:performance, 'Das Datum darf nicht in der Zukunft liegen!')  
      end
    rescue ArgumentError
      errors.add(:performance, 'Ein fehlerhaftes Datum wurde eingegeben!')
    end
  end
  
  # Valid Gender if Athlete can do a Performance 
  def should_valid_gender
    if not athlete
      errors.add(:performance, 'Es wurde kein(e) Sportler(in) gefunden.')
    elsif not discipline
      errors.add(:performance, 'Es wurde keine Disziplin gefunden.')
    elsif not Discipline.exists?(["name = ? AND gender_id = ?", discipline.name, athlete.gender_id])
      errors.add(:performance, 'Das Geschlecht der Sportlerin/des Sportlers ist fuer diese Disziplin nicht zugelassen.')
    end
  end
  
  # Valid Age if Athele can do a Performance 
  def should_valid_age
    if not athlete
      errors.add(:performance, 'Es wurde kein(e) Sportler(in) gefunden.')
    else
      athlete_age = Date.today.year - athlete.birthday.year
      age_range = AgeRange.find_by_age(athlete_age)[0]
      if not DisciplineAge.exists?(['discipline_id = ? AND age_range_id = ?', discipline.id, age_range.id])
        errors.add(:performance, 'Das Alter ist nicher erlaubt.')  
      end  
    end
  end
end
