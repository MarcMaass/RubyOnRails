class DisciplineAge < ActiveRecord::Base
  has_many :required_performances
  belongs_to :discipline
  belongs_to :age_range
  # attr_accessible :title, :body
end
