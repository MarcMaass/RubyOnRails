class SportFacilitiesController < ApplicationController
  # Use Ajax autocomplete to get the name of sport facilities
  autocomplete :sport_facility, :name, :full => true
end