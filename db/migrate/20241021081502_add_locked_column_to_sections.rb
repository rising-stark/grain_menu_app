class AddLockedColumnToSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :locked, :boolean, default: false, null: false
  end
end
