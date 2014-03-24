require 'test_helper'

class GenderTest < Test::Unit::TestCase
  # associations
  should have_many(:disciplines)
  should have_many(:athletes)
  # validations
  should validate_presence_of(:sex)
  should validate_uniqueness_of(:sex)
  # just m(ale) or f(emale), one char :-)
  should validate_format_of(:sex).with('m')
  should validate_format_of(:sex).with('w')
  # value tests
  should_not allow_value('mf').for(:sex)
  should_not allow_value('a').for(:sex)
  should_not allow_value('2').for(:sex)
end

