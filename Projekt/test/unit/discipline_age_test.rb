require 'test_helper'

class DisciplineAgeTest < Test::Unit::TestCase
  # foreign keys
  should belong_to(:discipline)
  should belong_to(:age_range)
  # validations
end
