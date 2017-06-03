class CreateTableTournamentsTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :table_tournaments_teams, id: false do |t|
      t.references :tournament, foreign_key: true, null: false, index: true
      t.references :team, foreign_key: true, null: false, index: true
    end
  end
end
