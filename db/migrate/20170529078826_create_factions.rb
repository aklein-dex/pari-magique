class CreateFactions < ActiveRecord::Migration[5.1]
  def change
    create_table :factions do |t|
      t.string :name, null: false, index: true, limit: 20

      t.timestamps
    end
  end
end
