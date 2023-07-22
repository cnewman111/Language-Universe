class Conversation < ApplicationRecord
  belongs_to :prompt
  belongs_to :user
  has_many :messages, dependent: :destroy
  scope :visible_to_user, -> (user) {where('user_id == ?', user.id)}
  LANGUAGES = ["English", "Spanish", "French", "Italian"].freeze
end
