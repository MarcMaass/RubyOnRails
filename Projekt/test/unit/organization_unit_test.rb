require 'test_helper'

class OrganizationUnitTest < Test::Unit::TestCase
	# Check Location
  should belong_to(:location)
  # Test associations
  should have_and_belong_to_many(:athletes)
  should have_and_belong_to_many(:sport_facilities)
  should have_many(:examiners)
  # Check
  should validate_presence_of(:street)
  should validate_presence_of(:name)
  should validate_presence_of(:house_number)
  should validate_uniqueness_of(:name).scoped_to(:location_id)
end
