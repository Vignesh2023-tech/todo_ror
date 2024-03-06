class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.date :due_date
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
