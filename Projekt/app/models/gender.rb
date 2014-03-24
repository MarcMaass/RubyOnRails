class Gender < ActiveRecord::Base
  # associations
  has_many :athletes
  has_many :disciplines
  # attributes
  attr_accessible :sex
  # validations
  validates :sex, :presence => true, :uniqueness => true, :format => {:with => /\A[mw]\z/}
end
