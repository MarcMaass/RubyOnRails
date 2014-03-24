class Medal < ActiveRecord::Base
  # associations
  has_many :required_performances
  attr_accessible :points, :sign
  # validators
  validates :points, :uniqueness => true, :presence => true
  validates :sign, :presence => true
end
