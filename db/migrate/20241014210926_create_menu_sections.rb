class CreateMenuSections < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_sections do |t|
      t.references :menu, null: false, foreign_key: true
      t.references :section, null: false, foreign_key: true
      t.integer :display_order, default: 0, null: false

      t.timestamps
    end
    add_index :menu_sections, [:menu_id, :section_id], unique: true
  end
end
