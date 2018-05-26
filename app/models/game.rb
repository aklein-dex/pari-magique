class Game < ApplicationRecord
  require 'csv'

  belongs_to :tournament
  belongs_to :stadium
  belongs_to :home, class_name: "Team"
  belongs_to :away, class_name: "Team"

  has_many :guesses

  validates :tournament_id, presence: true
  validates :home_id, presence: true
  validates :away_id, presence: true
  validates :result,
            length: { maximum: 5 },
            format: { with: /[\d]?[\d]-[\d]?[\d]/i },
            allow_blank: true
  validates :kickoff_at, presence: true
  validates :stage, presence: true
  validates :stadium_id, presence: true

  enum stage: [:one, :two, :three]
  enum round: [:round1, :round2, :round3, :round4, :round16, :quarter, :semi, :finale]
  enum group: [:A, :B, :C, :D, :E, :F, :G, :H]

  scope :next_5_games, -> { where("kickoff_at > ?", Time.now).order(:kickoff_at).limit(5)}
  scope :last_5_games, -> { where("kickoff_at < ?", Time.now).order(kickoff_at: :desc).limit(5)}
  scope :past_games,   -> { where("kickoff_at < ?", Time.now).order(kickoff_at: :desc)}

  after_validation :edit_result_past_games_only
  after_update :update_rankings, if: :saved_change_to_result?

  def kickoff_at_format(format = "%d %b, %H:%M")
    kickoff_at.strftime(format)
  end

  # Import all the games in the file
  def self.import(file, tournament_id)
    stadiums = {}
    teams = {}

    CSV.foreach(file.path, headers: true) do |row|
      round = row['Round'].to_i - 1

      # should be in UTC
      kickoff = row['Date'].to_datetime

      stadium = row['Location']
      if not stadiums.has_key?(stadium)
        stadium_ids = Stadium.where(name: stadium).pluck(:id)
        # todo handle case if stadium doesnt exist
        stadiums[stadium] = stadium_ids[0]
      end
      stadium_id = stadiums[stadium]

      home = row['Home Team']
      if not teams.has_key?(home)
        team_ids = Team.where(name: home).pluck(:id)
        # todo handle case if team doesnt exist
        teams[home] = team_ids[0]
      end
      home_id = teams[home]

      away = row['Away Team']
      if not teams.has_key?(away)
        team_ids = Team.where(name: away).pluck(:id)
        # todo handle case if team doesnt exist
        teams[away] = team_ids[0]
      end
      away_id = teams[away]

      group = row['Group'][-1]
      stage = "one"

      # todo handle exceptions
      Game.create!(:tournament_id => tournament_id, :round => round, :kickoff_at => kickoff, :stadium_id => stadium_id, :home_id => home_id, :away_id => away_id, :group => group)
    end
  end

  private

    # When the result of a game is updated we need to update the ranking
    def update_rankings
      if self.result_before_last_save.blank? and self.result.present?
        # A new result for the game was saved, so we update the rankings
        Ranking.update_rankings(self)
      elsif self.result_before_last_save.present? and self.result_before_last_save != self.result
        # The result of the game was updated
        Ranking.update_rankings(self, true)
      else
        # no need to update the ranking
      end
    end

    def edit_result_past_games_only
      # todo we should be able to edit the result only if now > kickoff_at
    end
end
