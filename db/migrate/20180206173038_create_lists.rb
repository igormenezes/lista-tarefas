class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :name
      t.integer :public
      t.integer :active

      t.timestamps
    end
  end
end
