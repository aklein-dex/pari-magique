class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false, limit: 20
      t.string :code, null: false, limit: 3
      t.string :flag, null: false, limit: 20

      t.timestamps
    end
    add_index :teams, :name, unique: true
  end
end
