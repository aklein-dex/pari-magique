class Ranking < ApplicationRecord
  belongs_to :league
  belongs_to :tournament
  belongs_to :member

  validates :member_id, presence: true
  validates :tournament_id, presence: true
  validates :league_id, presence: true

  validates :point3, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :point1, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :point0, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
