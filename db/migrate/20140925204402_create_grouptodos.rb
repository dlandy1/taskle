class CreateGrouptodos < ActiveRecord::Migration
  def change
    create_table :grouptodos do |t|
      t.string :title

      t.timestamps
    end
  end
end
