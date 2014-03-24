class CreateDisciplineAges < ActiveRecord::Migration
  def change
    create_table :discipline_ages do |t|
      t.references :discipline
      t.references :age_range
      
      t.timestamps
    end
    add_index :discipline_ages, :discipline_id
    add_index :discipline_ages, :age_range_id
  end
end
