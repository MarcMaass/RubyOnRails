class Sport < ActiveRecord::Base
  # associations
  has_and_belongs_to_many :examiners
  has_many :disciplines
  # attributes
  attr_accessible :name
  #validators
  validates :name, :uniqueness => true, :presence => true
end