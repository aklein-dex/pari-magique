class Stadium < ApplicationRecord

  validates :name,
            length: { maximum: 20 },
            presence: true
  validates :city,
            length: { maximum: 20 },
            presence: true
  validates :capacity,
            length: { maximum: 5 },
            presence: true
end
