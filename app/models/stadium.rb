class Stadium < ApplicationRecord

  validates :name,
            length: { maximum: 20 },
            presence: true
  validates :city,
            length: { maximum: 20 },
            presence: true
  validates :capacity,
            numericality: { only_integer: true, greater_than: 0 },
            length: { maximum: 6 },
            presence: true
end
