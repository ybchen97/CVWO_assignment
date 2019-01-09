class AddCompleteToTodoItem < ActiveRecord::Migration[5.2]
  def change
    add_column :todo_items, :complete, :boolean, { default: false }
  end
end
