class CreateLeaguesTournaments < ActiveRecord::Migration[5.1]
  def change
    create_table :leagues_tournaments, id: false do |t|
      t.references :tournament, foreign_key: true, null: false, index: true
      t.references :league, foreign_key: true, null: false, index: true
    end
  end
end
