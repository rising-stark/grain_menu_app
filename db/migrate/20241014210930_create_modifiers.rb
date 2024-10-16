class CreateModifiers < ActiveRecord::Migration[6.0]
  def change
    create_table :modifiers do |t|
      t.references :item, null: false, foreign_key: true, unique: true
      t.references :modifier_group, null: false, foreign_key: true
      t.integer :display_order, default: 0, null: false
      t.integer :default_quantity, default: 0, null: false
      t.float :price_override

      t.timestamps
    end
  end
end
