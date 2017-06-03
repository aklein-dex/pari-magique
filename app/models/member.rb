class Member < ApplicationRecord
  belongs_to :league
  belongs_to :user

  validates :league_id, presence: true
  validates :user_id, presence: true
  validates :occupation, presence: true


  enum occupation: [:player, :coach]
end
