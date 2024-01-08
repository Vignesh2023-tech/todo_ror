class RemoveDescriptionFromTodos < ActiveRecord::Migration[7.1]
  def change
    remove_column :todos, :description, :text
  end
end
