class Guess < ApplicationRecord
  belongs_to :member
  belongs_to :game
  belongs_to :league

  validates :member_id, presence: true
  validates :game_id, presence: true
  validates :league_id, presence: true
  validates :result,
            length: { maximum: 5 },
            format: { with: /[\d]?[\d]-[\d]?[\d]/i }
end
