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

  has_many :members
  has_many :leagues, :through => :members
  
  has_many :messages, dependent: :destroy

  def member_id_for_league(league_id)
    Member.where(:league_id => league_id).where(:user_id => id).first.id
  end

  # Return the occupation of the user for the league
  def league_occupation(league_id)
    return "coach"  if is_coach?(league_id)
    return "player" if is_player?(league_id)
    return "n/a"
  end

  # Check if the current_user is a coach for the param league
  def is_coach?(league_id)
    member = members.where(:league_id => league_id).first
    return member.occupation?(:coach) if member
    false
  end

  # Check if the current_user is a player for the param league
  def is_player?(league_id)
    member = members.where(:league_id => league_id).first
    return member.occupation?(:player) if member
    false
  end

  # For role inheritance. For example an admin can do everything that a manager can do.
  def role?(compare_to_role)
    User.roles[role] >= User.roles[compare_to_role]
  end
end
