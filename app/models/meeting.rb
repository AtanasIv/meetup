class Meeting < ActiveRecord::Base
  belongs_to :user

  default_scope -> { order(created_at: :desc) }
     validates :user_id, presence: true
      validates :content, presence: true, length: { maximum: 1000 }
      validates :place, presence: true, length: { maximum: 50 }
      validates :thedate, presence: true, length: { maximum: 10 }
       mount_uploader :picture, PictureUploader


#has_many :relates,  :class_name => 'Relate'
#has_many :users,  :through => :relates, :class_name => 'Relate'




 # has_many :passive_relates,         class_name:  "Relate",
                     #              foreign_key: "user_id",
                    #               dependent:   :destroy

#has_many :following, through: :passive_relates, source: :user_id


validates_format_of :thedate, :with => /\d{2}\/\d{2}\/\d{4}/, :message => "^Date must be in the following format: mm/dd/yyyy"

def picture_size
	if picture_size>3.megabytes
		errors.add(:picture, "Pictures must be less than 3MB")
	end
end

# def followss(other_meeting)
#     active_relates.create(meeting_id: other_meeting.id)
#   end

#   # Unfollows a user.
#   def unfollowss(other_meeting)
#     active_relates.find_by(meeting_id: other_meeting.id).destroy
#   end

#   # Returns true if the current user is following the other user.
#   def followingss?(other_meeting)
#     meetings.include?(other_meeting)
#   end


 
 def feed
  following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Meeting.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end


end
