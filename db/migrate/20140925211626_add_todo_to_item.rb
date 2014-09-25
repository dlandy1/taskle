class AddTodoToItem < ActiveRecord::Migration
  def change
    add_column :items, :todo_id, :integer
  end
end
