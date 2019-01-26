class CreateJoinTableTagTodoItem < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tags, :todo_items do |t|
      t.index :tag_id
      t.index :todo_item_id
    end
  end
end
