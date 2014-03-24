require 'test_helper'

class LocationTest < Test::Unit::TestCase
  # Locations belongs to districts
  should belong_to(:district)
  # Presence-Tests
  should validate_presence_of(:postal_code)
  should validate_presence_of(:name)
  # Uniqueness: Postal Code
  should validate_uniqueness_of(:postal_code)
  # Only five characters, just numbers
  should ensure_length_of(:postal_code).is_equal_to(5)
  should validate_format_of(:postal_code).with('12345')
  should_not allow_value('ABCDE').for(:postal_code)
  should_not allow_value('1234').for(:postal_code)
  # Associations
  should have_many(:sport_facilities)
  should have_many(:organization_units)
  should have_many(:athletes)
end
