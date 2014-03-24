require 'test_helper'

class DistrictChiefTest < Test::Unit::TestCase
  # association to a district
  should have_many(:performances)
end
