class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.float :value
      t.date :date
      t.references :athlete
      t.references :discipline
      t.references :examiner
      t.references :district_chief
      t.references :sport_facility
      t.boolean :inspected, :default => false

      t.timestamps
    end
    add_index :performances, :athlete_id
    add_index :performances, :discipline_id
    add_index :performances, :examiner_id
    add_index :performances, :district_chief_id
    add_index :performances, :sport_facility_id
  end
end
