class CreateTestAppointments < ActiveRecord::Migration
  def change
    create_table :test_appointments do |t|
      t.date :start_date
      t.time :time
      t.text :info_text
      t.boolean :cancelled
      t.references :discipline
      t.references :sport_facility
      t.references :district_chief

      t.timestamps
    end
    add_index :test_appointments, :discipline_id
    add_index :test_appointments, :sport_facility_id
    add_index :test_appointments, :district_chief_id
  end
end
