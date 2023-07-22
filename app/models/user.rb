class User < ApplicationRecord
    has_many :prompts, dependent: :destroy
    has_many :conversations, dependent: :destroy 
    has_many :messages, dependent: :destroy
end
