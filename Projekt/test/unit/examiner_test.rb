require 'test_helper'

class ExaminerTest < Test::Unit::TestCase
  # associations
  should have_and_belong_to_many(:sports)
  should have_many(:performances)
  # foreign keys:
  #should have_db_column(:organization_unit_id).of_type(:integer)
  should belong_to(:organization_unit)
  # only an athlete, orga_unit must be set
  # should validate_uniqueness_of(:athlete_id)
  # should validate_presence_of(:athlete_id)
  #should validate_presence_of(:organization_unit_id)
end
