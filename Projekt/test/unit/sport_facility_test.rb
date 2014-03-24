require 'test_helper'

class SportFacilityTest < Test::Unit::TestCase
	# association tests
  should have_many(:performances)
  should have_many(:test_appointments)
  should have_many(:disciplines).through(:test_appointments)
  # belong to
  should belong_to(:location)
  should belong_to(:organization_unit)
  # presence test
  should validate_presence_of(:name)
  should validate_presence_of(:street)
  should validate_presence_of(:house_number)
  # uniqueness test
  should validate_uniqueness_of(:name).scoped_to(:organization_unit_id)
end
