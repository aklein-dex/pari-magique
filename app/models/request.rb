class Request < ApplicationRecord
  belongs_to :user_id
  belongs_to :league_id

  validates :league_id, presence: true
  validates :user_id, presence: true
  validates :status, presence: true

  enum status: [:pending, :accepted, :rejected]
end
