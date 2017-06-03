class CreateGuesses < ActiveRecord::Migration[5.1]
  def change
    create_table :guesses do |t|
      t.references :member, foreign_key: true, null: false, index: true
      t.references :game, foreign_key: true, null: false
      t.references :league, foreign_key: true, null: false, index: true
      t.string :result, null: false, limit: 5

      t.timestamps
    end
  end
end
