class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :postal_code
      t.string :name
      t.references :district

      t.timestamps
    end
    add_index :locations, :district_id
  end
end
