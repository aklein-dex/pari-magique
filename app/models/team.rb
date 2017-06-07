class Team < ApplicationRecord
  has_and_belongs_to_many :tournaments

  validates :name,
            length: { maximum: 20 },
            presence: true
  validates :code,
            length: { maximum: 3 },
            presence: true
  validates :flag,
            length: { maximum: 20 },
            presence: true
  validates :selection,
            presence: true

  enum selection: [:country, :club]
end
