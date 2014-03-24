class OrganizationUnit < ActiveRecord::Base
	# associations
	has_and_belongs_to_many :athletes
	has_and_belongs_to_many :sport_facilities
	has_many :examiners
	# foreign keys
  belongs_to :location
  # attributes
  attr_accessible :house_number, :name, :street, :phone_number, :email, :url, :location
  accepts_nested_attributes_for :sport_facilities
  # validators
  validates :name, :presence => true, :uniqueness => {:scope => :location_id}
  validates :street, :presence => true
  validates :house_number, :presence => true
end
