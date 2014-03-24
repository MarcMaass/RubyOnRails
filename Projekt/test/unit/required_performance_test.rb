require 'test_helper'

class RequiredPerformanceTest < Test::Unit::TestCase
  # belong to discipline, gender, medal, agerange
  should belong_to(:discipline_age)
  should belong_to(:medal)
  # value > 0.0
  should validate_presence_of(:value)
  should validate_numericality_of(:value)
  should allow_value(0.0).for(:value)
  should_not allow_value(-0.1).for(:value)
end
