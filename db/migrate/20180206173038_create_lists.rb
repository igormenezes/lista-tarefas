class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :name
      t.integer :available, limit: 1
      t.integer :active, default: 1

      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :lists, :name, unique: true
  end
end
