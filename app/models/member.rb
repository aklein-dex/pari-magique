class Member < ApplicationRecord
  belongs_to :league
  belongs_to :user

  validates :league_id, presence: true
  validates :user_id, presence: true
  validates :occupation, presence: true


  enum occupation: [:player, :coach]

  # For role inheritance. For example an coach can do everything that a player can do.
  def occupation?(compare_to_occupation)
    Member.occupations[occupation] >= Member.occupations[compare_to_occupation]
  end
end
