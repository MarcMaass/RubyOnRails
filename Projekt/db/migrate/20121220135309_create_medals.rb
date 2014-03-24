class CreateMedals < ActiveRecord::Migration
  def change
    create_table :medals do |t|
      t.integer :points
      t.string :sign

      t.timestamps
    end
  end
end
