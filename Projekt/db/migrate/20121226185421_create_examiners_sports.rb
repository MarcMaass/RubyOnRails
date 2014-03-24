class CreateExaminersSports < ActiveRecord::Migration
  def change
    create_table :athletes_sports, :id => false do |t|
      t.integer :athlete_id, :null => false
      t.integer :sport_id, :null => false
    end 
  end
end
