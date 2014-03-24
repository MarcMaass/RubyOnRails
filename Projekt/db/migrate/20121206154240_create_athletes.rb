class CreateAthletes < ActiveRecord::Migration
  
  def change
    create_table :athletes do |t|
      t.string :email
      t.string :password_digest
      t.string :last_name
      t.string :first_name
      t.date :birthday
      t.references :gender
      t.string :street
      t.integer :house_number
      t.references :location
      t.string :phone
      t.attachment :picture
      t.boolean :activated, :default => false
      t.string :type
      t.references :organization_unit

      t.timestamps
    end
    add_index :athletes, :gender_id
    add_index :athletes, :location_id
    add_index :athletes, :organization_unit_id
  end
end
