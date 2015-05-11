class AddPictureToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :picture, :string
  end
end
