class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :category
      t.string :q
      t.integer :a1
      t.integer :a2
      t.integer :a3
      t.integer :c

      t.timestamps null: false
    end
  end
end
