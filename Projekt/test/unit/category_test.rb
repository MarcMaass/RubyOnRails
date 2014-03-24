require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  #associations
  should have_many(:disciplines)
  # presence
  should validate_presence_of(:name)
  # uniqueness
  should validate_uniqueness_of(:name)
end
