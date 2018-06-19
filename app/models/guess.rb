class Guess < ApplicationRecord
  belongs_to :member
  belongs_to :game
  belongs_to :faction

  # Make sure we can only have 1 bet for 1 user in 1 faction
  validates_uniqueness_of :member_id, scope: [:game_id, :faction_id]
  
  validates :member_id, presence: true
  validates :game_id, presence: true
  validates :faction_id, presence: true
  validates :result,
            length: { maximum: 5 },
            format: { with: /\A[\d]?[\d]-[\d]?[\d]\z/i }

  validate :before_game_starts

  # Return TRUE if the guess and the gameResult match
  def is_perfect_guess?(gameResult)
    return true if self.result.present? and self.result == gameResult
    false
  end

  # Return TRUE if the guess and the gameResult indicate the same winning team.
  # For example:
  #   TRUE if guess is 5-0 and gameResult is 1-0
  #   TRUE if guess is 3-3 and gameResult is 1-1
  #   FALSE if guess is 2-0 and gameResult is 0-2
  def is_good_guess?(gameResult)
    return false if self.result.blank? or gameResult.blank?
    
    guessArray = self.result.split("-")
    gameArray = gameResult.split("-")

    return true if (gameArray[0] < gameArray[1] && guessArray[0] < guessArray[1])
    return true if (gameArray[0] > gameArray[1] && guessArray[0] > guessArray[1])
    return true if (gameArray[0] == gameArray[1] && guessArray[0] == guessArray[1])

    return false
  end
  
  private
  
  # Make sure a guess can't be changed after the game has started
  def before_game_starts
    if Time.now > game.kickoff_at  
      errors.add(:guess, "can't create or update guess after the game has started")
    end
  end
  
  
end
