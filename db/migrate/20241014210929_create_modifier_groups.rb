class CreateModifierGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :modifier_groups do |t|
      t.string :identifier, null: false
      t.string :label, null: false
      t.integer :selection_required_min, default: 0, null: true
      t.integer :selection_required_max, null: true

      t.timestamps
    end
    add_index :modifier_groups, :identifier, unique: true
  end
end
