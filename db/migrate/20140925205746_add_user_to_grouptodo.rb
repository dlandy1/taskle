class AddUserToGrouptodo < ActiveRecord::Migration
  def change
    add_column :grouptodos, :user_id, :integer
  end
end
