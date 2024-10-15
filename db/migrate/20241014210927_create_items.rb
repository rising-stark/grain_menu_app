class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :identifier, null: false
      t.string :label, null: false
      t.string :description
      t.float :price, null: false
      t.string :type, null: false

      t.timestamps
    end
    add_index :items, :identifier, unique: true
    add_index :items, :type
  end
end
