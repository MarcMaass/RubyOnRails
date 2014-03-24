require 'test_helper'

class DistrictTest < Test::Unit::TestCase
	# Should have federal state and district chief
  should belong_to(:federal_state)
  should belong_to(:district_chief)
  # Name should not be blank
  should validate_presence_of(:name)
  # Name should be unique
  should validate_uniqueness_of(:name)
  # Name should not be blank
  should_not allow_value("").for(:name)
  # Locations are in Districts
  should have_many(:locations)
  # Only one district chief
end
