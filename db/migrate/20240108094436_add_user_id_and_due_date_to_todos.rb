class AddUserIdAndDueDateToTodos < ActiveRecord::Migration[7.1]
  def change
    add_reference :todos, :user, null: false, foreign_key: true
    add_column :todos, :due_date, :date
  end
end
