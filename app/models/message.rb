class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  def sender
    User.find_by_id(sender_id) || User.new(email: "nobody@but.you")
  end
  
end
