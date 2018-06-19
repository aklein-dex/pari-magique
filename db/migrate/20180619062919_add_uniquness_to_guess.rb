class AddUniqunessToGuess < ActiveRecord::Migration[5.1]
  def change
    add_index :guesses, [:member_id, :game_id, :faction_id], unique: true
  end
end
