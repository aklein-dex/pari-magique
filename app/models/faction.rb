class Faction < ApplicationRecord
  has_and_belongs_to_many :tournaments

  has_many :members
  has_many :users, :through => :members
  has_many :requests
  has_many :rankings

  has_many :chat_rooms, dependent: :destroy

  validates :name,
            length: { maximum: 20 },
            presence: true


  # Used to get the factions of the user.
  def self.for_user(user)
    #joins(:users).where("users.id" => user.id)
    joins(:users).where(users: { id: user.id })
  end

  # Used to get the factions of the user that have not been approved yet (still pending).
  def self.with_pending_requests(user)
    joins(:requests).where(requests: { user_id: user.id, status: Request.statuses[:pending] })
  end

  # Used to get the factions that a user can send a request to.
  def self.can_send_request(user)
    left_outer_joins(:requests).where("requests.id is null or requests.user_id != ?", user.id).where("factions.id not in (select faction_id from members where user_id = ?)", user.id)
  end
end
