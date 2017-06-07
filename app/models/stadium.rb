class Stadium < ApplicationRecord

  validates :name,
            length: { maximum: 20 },
            presence: true
  validates :city,
            length: { maximum: 20 },
            presence: true
  validates :capacity,
            numericality: { only_integer: true },
            length: { maximum: 5 },
            presence: true
end
