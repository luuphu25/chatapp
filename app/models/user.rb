class User < ApplicationRecord
  has_many :friendships
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :active_friends, -> { where(friendships: { accepted: true}) }, through: :friendships, source: :friend
  has_many :received_friends, -> { where(friendships: { accepted: true}) }, through: :received_friendships, source: :user
  has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
  has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user
  has_secure_password

  validates :email , presence: true, uniqueness: true 
  def friends
    active_friends | received_friends
  end
  
  def pending
    pending_friends | requested_friendships
  end


  def to_s
    email
  end

  def received_messages
    Message.where(recipient: self)
  end

  def sent_messages
    Message.where(sender: self)
  end

  def lastest_received_messages(n)
    received_messages.order(created_at: :desc).limit(n)
  end

  def unread_messages
    received_messages.unread
  end

  def self.from_omniauth(auth)
    # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
    # and figure out how to get email for this user.
    # Note that Facebook sometimes does not return email,
    # in that case you can use facebook-id@facebook.com as a workaround
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    user = where(email: email).first_or_initialize
    #
    # Set other properties on user here. Just generate a random password. User does not have to use it.
    # You may want to call user.save! to figure out why user can't save
    #
    # Finally, return user
    user.save && user
  end

end
