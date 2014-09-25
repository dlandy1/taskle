class AddItemToGrouptodo < ActiveRecord::Migration
  def change
    add_column :grouptodos, :item_id, :integer
  end
end
