class CreateOrganizationUnits < ActiveRecord::Migration
  def change
    create_table :organization_units do |t|
      t.string :name
      t.string :street
      t.integer :house_number
      t.string :phone_number
      t.string :email
      t.string :url
      t.references :location

      t.timestamps
    end
    add_index :organization_units, :location_id
  end
end
