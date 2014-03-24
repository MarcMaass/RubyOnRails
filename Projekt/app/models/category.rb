class Category < ActiveRecord::Base
  # associations
  has_many :disciplines
  # attributes
  attr_accessible :name
  # validators
  validates :name, :uniqueness => true, :presence => true
end
