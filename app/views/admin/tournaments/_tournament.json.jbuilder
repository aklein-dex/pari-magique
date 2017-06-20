json.extract! tournament, :id, :name, :location, :year, :created_at, :updated_at
json.url tournament_url(tournament, format: :json)
