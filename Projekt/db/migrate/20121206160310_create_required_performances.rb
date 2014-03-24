class CreateRequiredPerformances < ActiveRecord::Migration
  def change
    create_table :required_performances do |t|
      t.float :value
      t.references :discipline_age
      t.references :medal
      
      t.timestamps
    end
    add_index :required_performances, :discipline_age_id
    add_index :required_performances, :medal_id
  end
end
