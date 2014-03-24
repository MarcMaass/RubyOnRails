class SportFacility < ActiveRecord::Base
	# associations
	has_and_belongs_to_many :organization_units
	has_many :test_appointments
	has_many :disciplines
	has_many :disciplines, :through => :test_appointments
	has_many :performances
	# foreign keys
  belongs_to :location
  # attributes
  attr_accessible :house_number, :name, :street, :location, :organization_unit, :test_appointments, :performances, :disciplines 
  # validators
  validates :name, :presence => true, :uniqueness => {:scope => :location_id}
  validates :street, :presence => true
  validates :house_number, :presence => true
  validates :location, :presence => true
end
