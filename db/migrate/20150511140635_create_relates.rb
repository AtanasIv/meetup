class CreateRelates < ActiveRecord::Migration
  def change
    create_table :relates do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end
       add_index :relates, :follower_id
    add_index :relates, :followed_id
    add_index :relates, [:follower_id, :followed_id], unique: true
  end
end
