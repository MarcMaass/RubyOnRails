class CreateSportFacilities < ActiveRecord::Migration
  def change
    create_table :sport_facilities do |t|
      t.string :name
      t.string :street
      t.integer :house_number
      t.references :location

      t.timestamps
    end
    add_index :sport_facilities, :location_id
  end
end
