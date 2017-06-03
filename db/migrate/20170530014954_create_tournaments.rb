class CreateTournaments < ActiveRecord::Migration[5.1]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false, index: true, limit: 20
      t.string :location, null: false, limit: 20
      t.integer :year, null: false, limit: 4

      t.timestamps
    end
  end
end
