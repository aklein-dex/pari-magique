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
  enum round: [:round1, :round2, :round3, :round4, :round16, :quarter, :semi, :finale3, :finale]
  enum group: [:A, :B, :C, :D, :E, :F, :G, :H]

  scope :next_5_games, -> { where("kickoff_at > ?", Time.now).order(:kickoff_at).limit(5)}
  scope :last_5_games, -> { where("kickoff_at < ?", Time.now).order(kickoff_at:  :desc).limit(5)}
  
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
end
