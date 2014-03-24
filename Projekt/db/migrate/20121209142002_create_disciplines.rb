class CreateDisciplines < ActiveRecord::Migration
  def change
    create_table :disciplines do |t|
      t.string :name
      t.date :year
      t.references :gender
      t.references :unit
      t.references :category
      t.references :sport

      t.timestamps
    end
    add_index :disciplines, :gender_id
    add_index :disciplines, :unit_id
    add_index :disciplines, :category_id
    add_index :disciplines, :sport_id
  end
end
