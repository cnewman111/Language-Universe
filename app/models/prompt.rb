class Prompt < ApplicationRecord
  belongs_to :user
  has_many :conversations, dependent: :destroy
  validates :ai_name, :setting, :description, :user_id, presence: :true
  scope :visible_by_all, -> { where(visible_to_all: true) }
  scope :visible_by_user, -> (user) { where('user_id = ?', user.id).or(visible_by_all) }
end
