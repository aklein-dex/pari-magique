class Request < ApplicationRecord
  belongs_to :user
  belongs_to :faction

  validates :faction_id, presence: true
  validates :user_id, presence: true
  validates :status, presence: true

  enum status: [:pending, :accepted, :rejected]

  scope :pending, -> { where(status: Request.statuses[:pending]).includes(:user)}
end
