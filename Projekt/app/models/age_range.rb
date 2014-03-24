class AgeRange < ActiveRecord::Base
  scope :find_by_age, lambda { |age|
    where('min_age <= ? AND ? <= max_age', age, age)    
  }
  # associations
  has_many :discipline_ages
  # attributes
  attr_accessible :max_age, :min_age
  @@minimum_age = 5 # minimum age... used for validation
  # validates
  validates :min_age, :uniqueness => true, :presence => true, :numericality => {:greater_than => @@minimum_age, :only_integer => true}
  validates :max_age, :presence => true, :numericality => {:greater_than_or_equals => :min_age, :only_integer => true}
end
