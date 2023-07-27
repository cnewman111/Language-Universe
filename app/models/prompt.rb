class Prompt < ApplicationRecord
  belongs_to :user
  has_many :conversations, dependent: :destroy
  validates :ai_name, :setting, :description, :user_id, presence: :true
  scope :visible_to_all, -> { where(visible_to_all?: true) }
  scope :visible_to_user, -> (user) { where('user_id = ?', user.id).or(visible_to_all) }

  def user_can_modify(user)
    if !user.is_admin and visible_to_all?
      errors.add(:user, " cannot make changes to a default prompt")
    end 
  end 
end
