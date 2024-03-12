class AddRandomNumberToTodo < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :rn, :integer
  end
end
