require 'test_helper'

class SportTest < ActiveSupport::TestCase
  #associations
  should have_many(:disciplines)
  should have_and_belong_to_many(:examiners)
  # presence
  should validate_presence_of(:name)
  # uniqueness
  should validate_uniqueness_of(:name)
end