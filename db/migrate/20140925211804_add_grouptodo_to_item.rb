class AddGrouptodoToItem < ActiveRecord::Migration
  def change
    add_column :items, :grouptodo_id, :integer
  end
end
