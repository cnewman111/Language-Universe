class Conversation < ApplicationRecord
  belongs_to :prompt
  belongs_to :user
  has_many :messages, dependent: :destroy
  validates :training_language, :native_language, :prompt_id, :user_id, presence: :true
  scope :visible_to_user, -> (user) {where('user_id == ?', user.id)}
  LANGUAGES = ["English", "Spanish", "French", "Italian"].freeze
end
