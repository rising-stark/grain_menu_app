class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.string :identifier, null: false
      t.string :label, null: false
      t.string :state, null: false, default: "inactive"
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
    add_index :menus, :identifier, unique: true
  end
end
