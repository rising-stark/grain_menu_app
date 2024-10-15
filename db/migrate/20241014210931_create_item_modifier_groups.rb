class CreateItemModifierGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :item_modifier_groups do |t|
      t.references :item, null: false, foreign_key: true
      t.references :modifier_group, null: false, foreign_key: true

      t.timestamps
    end
    add_index :item_modifier_groups, [:item_id, :modifier_group_id], unique: true
  end
end
