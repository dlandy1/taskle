class CreateGrouptodos < ActiveRecord::Migration
  def change
    create_table :grouptodos do |t|
      t.string :title
      t.integer :checkbox

      t.timestamps
    end
  end
end
