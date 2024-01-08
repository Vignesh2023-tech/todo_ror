class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.references :user, foreign_key: true
      t.date :due_date

      t.timestamps
    end
  end
end
