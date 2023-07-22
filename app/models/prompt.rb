class Prompt < ApplicationRecord
  belongs_to :user
  validates :ai_name, :setting, :description, :user_id, presence: :true
  scope :visible_to_all, -> { where(visible_to_all?: true) }
  scope :visible_to_user, -> (user) { where('user_id = ?', user.id).or(visible_to_all) }
end
