class User < ApplicationRecord
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_secure_password

  validates :email , presence: true, uniqueness: true  

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

end
