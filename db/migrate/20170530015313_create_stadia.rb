class CreateStadia < ActiveRecord::Migration[5.1]
  def change
    create_table :stadia do |t|
      t.string :name, null: false, index: true, limit: 20
      t.string :city, null: false, limit: 20
      t.integer :capacity, null: false, limit: 5

      t.timestamps
    end
  end
end
