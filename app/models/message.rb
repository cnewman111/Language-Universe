class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates :body, :conversation_id, presence: :true
  validate :has_legal_creating_entity
  after_create_commit { broadcast_append_to self.conversation_id }

  ENTITIES = ["user", "ai", "system"].freeze 

  private
  def has_legal_creating_entity
    if !ENTITIES.include?(creating_entity)
      errors.add(:creating_entity, "must be a valid entity in Message::ENTITIES") 
    elsif creating_entity == :user && !User.find(user_id)
      errors.add(:user_id, "must reference a valid user")
    end 
  end 
end
