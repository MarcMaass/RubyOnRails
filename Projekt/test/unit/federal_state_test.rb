require 'test_helper'

class FederalStateTest < Test::Unit::TestCase
	# Testing the connection to districts
	should have_many(:districts)
	# Name should be unique
	should validate_uniqueness_of(:name)
	# and not null
	should validate_presence_of(:name)
  # Testing emptyness of field name
  should_not allow_value("").for(:name)
end
