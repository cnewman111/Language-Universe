class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  after_create_commit { broadcast_append_to self.conversation_id }
end
