class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.belongs_to :tournament, foreign_key: true, null: false, index: true
      t.references :home, foreign_key: { to_table: :teams }, null: false, index: true
      t.references :away, foreign_key: { to_table: :teams }, null: false, index: true
      t.string :result, null: false, default: "", limit: 5
      t.datetime :schedule, null: false
      t.integer :type
      t.integer :pool
      t.belongs_to :stadium, foreign_key: true, null: false

      t.timestamps
    end
  end
end
