class Message < ApplicationRecord
  def sender
    User.find_by_id(sender_id) || User.new(email: "nobody@but.you")
  end
end
