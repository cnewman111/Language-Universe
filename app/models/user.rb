class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable, :rememberable, :validatable
  has_many :prompts, dependent: :destroy
  has_many :conversations, dependent: :destroy 
end
