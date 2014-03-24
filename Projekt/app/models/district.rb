class District < ActiveRecord::Base
  # associations
  has_many :locations
  # foreign keys
  belongs_to :federal_state
  belongs_to :district_chief
  
  attr_accessible :name, :district_chief
  validates :name, :uniqueness => true, :presence => true
end
