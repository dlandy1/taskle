class RemoveItemFromTodos < ActiveRecord::Migration
  def change
    remove_column :todos, :item_id, :integer
  end
end
