class OrganzationUnitsSportFacilities < ActiveRecord::Migration
  def change
    create_table :organization_units_sport_facilities, :id => false do |t|
      t.integer :organization_unit_id, :null => false
      t.integer :sport_facility_id, :null => false
    end
  end
end
