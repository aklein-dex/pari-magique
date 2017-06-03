class Tournament < ApplicationRecord
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :leagues

  validates :name,
            length: { maximum: 20 },
            presence: true
  validates :location,
            length: { maximum: 20 },
            presence: true
  validates :year,
            length: { maximum: 4 },
            presence: true
end
