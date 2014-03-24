require 'test_helper'

class AthleteTest < Test::Unit::TestCase
  # associations
  should have_and_belong_to_many(:organization_units)
  should have_many(:disciplines).through(:performances)
  # foreign keys
  should belong_to(:location)
  should belong_to(:gender)
  # unique fields:
  should validate_uniqueness_of(:email)
  # presence fields:
  should validate_presence_of(:email)
  should validate_presence_of(:password_digest)
  should validate_presence_of(:last_name)
  should validate_presence_of(:first_name)
  should validate_presence_of(:birthday)
  should validate_presence_of(:street)
  should validate_presence_of(:house_number)
  should validate_presence_of(:birthday)
  # special validations
  should ensure_length_of(:password).is_at_least(8)
  # TODO: format email, phone, minimum birthdate > 6 years
  # value tests:
  should allow_value('1').for(:house_number)
  should_not allow_value('0').for(:house_number)
  should_not allow_value('-1').for(:house_number)
end
