class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  def self.unread
    self.where(read_at: nil)
  end

  def sender
    User.find_by_id(sender_id) || User.new(email: "nobody@but.you")
  end

  def mark_as_read!
    self.read_at = Time.now
    save!
  end

  def receiver    
    User.find_by_id(recipient_id)    
  end

  def read?
    read_at
  end
  
end
