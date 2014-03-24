class CreateAthletesOrganizationUnits < ActiveRecord::Migration
  def change
    create_table :athletes_organization_units, :id => false do |t|
      t.integer :athlete_id, :null => false
      t.integer :organization_unit_id, :null => false
    end
  end
end
