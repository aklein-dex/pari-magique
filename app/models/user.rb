class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:member, :manager, :admin]

  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }
  validates :time_zone,
            :presence => true

  has_many :members
  has_many :factions, :through => :members

  has_many :messages, dependent: :destroy

  def member_id_for_faction(faction_id)
    Member.where(:faction_id => faction_id).where(:user_id => id).first.id
  end

  # Return the occupation of the user for the faction
  def faction_occupation(faction_id)
    return "coach"  if is_coach?(faction_id)
    return "player" if is_player?(faction_id)
    return "n/a"
  end

  # Check if the current_user is a coach for the param faction
  def is_coach?(faction_id)
    member = members.where(:faction_id => faction_id).first
    return member.occupation?(:coach) if member
    false
  end

  # Check if the current_user is a player for the param faction
  def is_player?(faction_id)
    member = members.where(:faction_id => faction_id).first
    return member.occupation?(:player) if member
    false
  end

  # For role inheritance. For example an admin can do everything that a manager can do.
  def role?(compare_to_role)
    User.roles[role] >= User.roles[compare_to_role]
  end
end
