json.extract! game, :id, :tournament_id, :home_id, :away_id, :result, :kickoff_at, :type, :pool, :stadium_id, :created_at, :updated_at
json.url game_url(game, format: :json)