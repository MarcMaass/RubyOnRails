class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :name
      t.references :federal_state
      t.references :district_chief
      
      t.timestamps
    end
    add_index :districts, :federal_state_id
    add_index :districts, :district_chief_id
  end
end
