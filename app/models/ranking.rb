class Ranking < ApplicationRecord
  belongs_to :league
  belongs_to :tournament
  belongs_to :member

  validates :member_id, presence: true
  validates :tournament_id, presence: true
  validates :league_id, presence: true

  validates :point3, numericality: { only_integer: true }
  validates :point1, numericality: { only_integer: true }
  validates :point0, numericality: { only_integer: true }
end
