class Game < ApplicationRecord
  belongs_to :tournament
  belongs_to :stadium
  belongs_to :home, class_name: "Team"
  belongs_to :away, class_name: "Team"

  validates :tournament_id, presence: true
  validates :home_id, presence: true
  validates :away_id, presence: true
  validates :result,
            length: { maximum: 5 },
            format: { with: /[\d]?[\d]-[\d]?[\d]/i }
  validates :kickoff_at, presence: true
  validates :stage, presence: true
  validates :stadium_id, presence: true

  enum stage: [:pool, :huitieme, :quarter, :semi, :finale]
  enum pool: [:A, :B, :C, :D, :E, :F, :G, :H]
end
