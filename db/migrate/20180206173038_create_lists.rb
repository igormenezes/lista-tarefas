class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :name
      t.string :available
      t.integer :active

      t.timestamps
    end
  end
end
