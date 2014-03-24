require 'test_helper'

class UnitTest < Test::Unit::TestCase
  #associations
  should have_many(:disciplines)
  # validations
  should validate_uniqueness_of(:name)
  # presences
  should validate_presence_of(:name)
end
