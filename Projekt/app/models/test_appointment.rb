class TestAppointment < ActiveRecord::Base
	# foreign keys
	belongs_to :sport_facility
	belongs_to :discipline
	# attributes
  attr_accessible :cancelled, :date, :info_text, :time
end
