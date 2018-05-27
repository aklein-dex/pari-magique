# One chat room is created for each faction.
class ChatRoom < ApplicationRecord
  belongs_to :faction
  
  has_many :messages, dependent: :destroy
end
