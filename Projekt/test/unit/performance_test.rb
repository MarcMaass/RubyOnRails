require 'test_helper'

class PerformanceTest < Test::Unit::TestCase
  # foreign keys
  should belong_to(:athlete)
  should belong_to(:examiner)
  should belong_to(:district_chief)
  should belong_to(:sport_facility)
  should belong_to(:discipline)
  # value
  should validate_presence_of(:athlete)
  should validate_presence_of(:sport_facility)
  should validate_presence_of(:discipline)
  should validate_presence_of(:examiner)
  should validate_presence_of(:value)
  should validate_numericality_of(:value)
  # tests with value
  should allow_value(1.0).for(:value)
  should_not allow_value(-0.1).for(:value)
  should allow_value("01.01.2013".to_date).for(:value)
  should_not allow_value("30.12.2013".to_date).for(:value)
end
