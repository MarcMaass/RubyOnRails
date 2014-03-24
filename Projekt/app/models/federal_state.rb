class FederalState < ActiveRecord::Base
  has_many :districts
  attr_accessible :name
  # Validator for FederalState
  validates :name, :presence => true, :uniqueness => true
end