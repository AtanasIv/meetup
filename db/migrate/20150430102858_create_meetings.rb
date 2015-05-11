class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.text :content
      t.string :place
      t.string :thedate
      t.references :user, index: true

      t.timestamps null: false
    end
     add_index :meetings, [:user_id, :created_at]
  end
end
