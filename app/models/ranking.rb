class Ranking < ApplicationRecord
  belongs_to :faction
  belongs_to :tournament
  belongs_to :member

  validates :member_id, presence: true
  validates :tournament_id, presence: true
  validates :faction_id, presence: true

  validates :point3, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :point1, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :point0, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  # The sum of the points
  def points
    self.point3 * 3 + self.point1
  end
  
  # could use this to increment but it does 2 queries (select and update) so it's not better:
  #   Ranking.where(:member_id => guess.member_id, :tournament_id => @game.tournament_id, :faction_id => guess.faction_id).first.increment!(:point3)
  def self.update_rankings(game, undo_old_result = false)
    guesses = Guess.where(:game_id => game.id)
    guesses.each do |guess|
      ranking = Ranking.where(:member_id => guess.member_id, :tournament_id => game.tournament_id, :faction_id => guess.faction_id).first
      
      # The result of the game was updated, so we should remove point(s) first.
      if undo_old_result
        increment_point(guess, ranking, game.result_before_last_save, -1)
      end
      
      increment_point(guess, ranking, game.result, 1)
      ranking.save
    end
  end
  
  private
    # nb can be +1 or -1
    def self.increment_point(guess, ranking, result, nb)
      if guess.is_perfect_guess?(result)
        ranking.point3 = ranking.point3 + nb;
      elsif guess.is_good_guess?(result)
        ranking.point1 = ranking.point1 + nb;
      else
        ranking.point0 = ranking.point0 + nb;
      end
    end
end
