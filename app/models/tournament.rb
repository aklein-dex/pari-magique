class Tournament < ApplicationRecord
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :leagues
  has_many :games

  validates :name,
            length: { maximum: 20 },
            presence: true
  validates :location,
            length: { maximum: 20 },
            presence: true
  validates :year,
            numericality: { only_integer: true },
            length: { is: 4 },
            presence: true
end
