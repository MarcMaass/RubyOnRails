require 'test_helper'

class DisciplineTest < ActiveSupport::TestCase
  # associations
  should have_many(:discipline_ages)
  should have_many(:athletes).through(:performances)
  should have_many(:sport_facilities).through(:test_appointments)
  # foreign keys
  should belong_to(:sport)
  should belong_to(:gender)
  should belong_to(:category)
  should belong_to(:unit)
  # validations
  should validate_presence_of(:year)
  should validate_presence_of(:name)
  # unique name under scope of year
  should validate_uniqueness_of(:year).scoped_to([:name, :gender_id])
end
