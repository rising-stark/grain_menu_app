class AddLockedColumnToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :locked, :boolean, default: false, null: false
  end
end
