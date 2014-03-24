require 'test_helper'

class AgeRangeTest < Test::Unit::TestCase
  # associations
  should have_many(:discipline_ages)
  # presence
  should validate_presence_of(:min_age)
  should validate_presence_of(:max_age)
  # uniqueness
  should validate_uniqueness_of(:min_age)
  # numeric?
  should validate_numericality_of(:min_age).only_integer
  should validate_numericality_of(:max_age).only_integer
  # extra tests
  should_not allow_value(0).for(:min_age)
  should_not allow_value(6 - 7).for(:min_age)
end
