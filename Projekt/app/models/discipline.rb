class Discipline < ActiveRecord::Base
  # query scope
  scope :distinct_category, lambda { |category_id|
    select('id, name, gender_id').
    from('disciplines d').
    where('d.id = (SELECT d1.id FROM disciplines d1 WHERE d1.name = d.name LIMIT 1) AND category_id = ?', category_id).
    order('d.gender_id, d.name')
  }
  
  # associations
  has_many :discipline_ages
  has_many :performances
  has_many :athletes, :through => :performances
  has_many :test_appointments
  has_many :sport_facilities, :through => :test_appointments
  # foreign keys
  belongs_to :category
  belongs_to :sport
  belongs_to :gender
  belongs_to :unit
  # attributes
  attr_accessible :name, :year, :gender
  #validations
  validates :year, :presence => true, :uniqueness => {:scope => [:name, :gender_id]}
  validates :name, :presence => true
  validates :gender, :presence => true
  
  private
  
  def get_discipline_with_gender
    amount = Discipline.where(:name => name).count()
    if amount > 1
      "#{self.name} (m/w)"
    else
      "#{self.name} (#{self.gender.sex})"
    end
  end
  
end
