class CreateRankings < ActiveRecord::Migration[5.1]
  def change
    create_table :rankings do |t|
      t.references :league, foreign_key: true, null: false
      t.references :tournament, foreign_key: true, null: false
      t.references :member, foreign_key: true, null: false
      t.integer :point3, null: false, default: 0
      t.integer :point1, null: false, default: 0
      t.integer :point0, null: false, default: 0

      t.timestamps
    end
  end
end
