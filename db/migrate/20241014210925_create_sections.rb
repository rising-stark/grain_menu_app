class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.string :identifier, null: false
      t.string :label, null: false
      t.string :description

      t.timestamps
    end
    add_index :sections, :identifier, unique: true
  end
end
