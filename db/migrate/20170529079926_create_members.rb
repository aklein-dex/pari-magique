class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.references :faction, foreign_key: true, null: false, index: true
      t.references :user, foreign_key: true, null: false, index: true
      t.integer :occupation, null: false, default: 0
      t.string :username, :null => false
      
      t.timestamps
    end
  end
end
