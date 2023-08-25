class Message < ApplicationRecord
  belongs_to :conversation
  validates :body, :conversation_id, presence: :true
  validate :has_legal_creating_entity
  after_create_commit { broadcast_append_to self.conversation_id }
  scope :user_messages, -> { where(creating_entity: ENTITIES[0]) }
  scope :character_messages, -> { where(creating_entity: ENTITIES[1]) }
  scope :translator_messages, -> { where(creating_entity: ENTITIES[2]) }

  ENTITIES = ["user", "ai", "system"].freeze 

  private
  def has_legal_creating_entity
    if !ENTITIES.include?(creating_entity)
      errors.add(:creating_entity, "must be a valid entity in Message::ENTITIES") 
    end 
  end 
end
