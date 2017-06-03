class League < ApplicationRecord
  has_and_belongs_to_many :tournaments

  has_many :members
  has_many :users, :through => :members

  validates :name,
            length: { maximum: 20 },
            presence: true
end
