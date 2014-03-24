require 'test_helper'

class MedalTest < Test::Unit::TestCase
  # associations
  should have_many(:required_performances)
  # test presence 
  should validate_presence_of(:points)
  should validate_presence_of(:sign)
  # uniqueness
  should validate_uniqueness_of(:points)
end
