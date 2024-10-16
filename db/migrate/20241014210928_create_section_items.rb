class CreateSectionItems < ActiveRecord::Migration[6.0]
  def change
    create_table :section_items do |t|
      t.references :section, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true, unique: true
      t.integer :display_order, default: 0, null: false

      t.timestamps
    end
  end
end
