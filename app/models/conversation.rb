class Conversation < ApplicationRecord
  belongs_to :prompt
  belongs_to :user
  has_many :messages
  LANGUAGES = ["English", "Spanish", "French", "Italian"].freeze
end
