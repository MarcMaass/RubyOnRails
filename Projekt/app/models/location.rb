class Location < ActiveRecord::Base
  scope :fetch_postal_code_and_name, lambda { |lis|
    postal_code, name = lis
    where(:postal_code => postal_code, :name => name)
  }
  
  has_many :organization_units
  has_many :athletes
  has_many :sport_facilities
  # foreign keys
  belongs_to :district
  attr_accessible :name, :postal_code
  validates :postal_code, :uniqueness => true , :presence => true, :length => { :is => 5 }, :format => { :with => /\A\d{5}\z/}
  validates :name, :presence => true
  
  def postal_code_and_name
    "#{self.postal_code}  #{self.name}"
  end
  
end
