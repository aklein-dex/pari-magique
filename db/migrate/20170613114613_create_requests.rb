class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.references :user_id, foreign_key: true, null: false
      t.references :league_id, foreign_key: true, null: false
      t.datetime :accepted_at
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
