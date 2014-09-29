class RemoveGrouptodoFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :grouptodo_id, :integer
  end
end
