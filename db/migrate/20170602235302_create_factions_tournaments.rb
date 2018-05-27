class CreateFactionsTournaments < ActiveRecord::Migration[5.1]
  def change
    create_table :factions_tournaments, id: false do |t|
      t.references :tournament, foreign_key: true, null: false, index: true
      t.references :faction, foreign_key: true, null: false, index: true
    end
  end
end
