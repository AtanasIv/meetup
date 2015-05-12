class Relate < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "Meeting"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
