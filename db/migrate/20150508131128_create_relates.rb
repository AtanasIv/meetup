class CreateRelates < ActiveRecord::Migration
  def change
    create_table :relates do |t|
      t.integer :user_id
      t.integer :meeting_id

      t.timestamps null: false
    end
       add_index :relates, :user_id
    add_index :relates, :meeting_id
       add_index :relates, [:user_id, :meeting_id], unique: true
  end
end
