class User < ActiveRecord::Base
has_many :meetings, dependent: :destroy



has_many :relates,  :class_name => 'Relate'
has_many :meetings, :through => :relates, :class_name => 'Relate'

	attr_accessor :remember_token
 before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  #has_many :following, through: :active_relationships,  source: :followed
  #has_many :followers, through: :passive_relationships, source: :follower


validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/




  #has_many :active_relates,         class_name:  "Relate",
                             #      foreign_key: "meeting_id",
                               #    dependent:   :destroy

#has_many :, through: :active_relates, source: :meeting_id

   def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
   def User.new_token
    SecureRandom.urlsafe_base64
  end
   def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  def authenticated?(remember_token)
  	return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
   def forget
    update_attribute(:remember_digest, nil)
  end

 def feed
  following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Meeting.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end



  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

 def followss(other_meeting)
    active_relates.create(meeting_id: other_meeting.id)
  end

  # Unfollows a user.
  def unfollowss(other_meeting)
    active_relates.find_by(meeting_id: other_meeting.id).destroy
  end

  # Returns true if the current user is following the other user.
  def followingss?(other_meeting)
    meetings.include?(other_meeting)
  end





end
