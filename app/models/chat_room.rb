# One chat room is created for each league.
class ChatRoom < ApplicationRecord
  belongs_to :league
  
  has_many :messages, dependent: :destroy
end
