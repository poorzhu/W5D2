class ChangePost < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :sub_id, :integer, null: true
  end
end
