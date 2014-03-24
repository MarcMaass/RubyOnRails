class CreateAgeRanges < ActiveRecord::Migration
  def change
    create_table :age_ranges do |t|
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end
end
