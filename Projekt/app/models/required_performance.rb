class RequiredPerformance < ActiveRecord::Base
  # foreign keys
  belongs_to :discipline_age
  belongs_to :medal
  #value = the required performance
  attr_accessible :value
  validates :value, :presence => true
  validates_numericality_of :value, :greater_than_or_equal_to => 0.0
end
