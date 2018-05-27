class Tournament < ApplicationRecord
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :factions
  has_many :games
  has_many :rankings

  validates :name,
            length: { maximum: 20 },
            presence: true
  validates :location,
            length: { maximum: 20 },
            presence: true
  validates :year,
            numericality: { only_integer: true, greater_than: 0 },
            length: { is: 4 },
            presence: true
end
