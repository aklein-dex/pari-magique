module ApplicationHelper
  def joined_leagues
    @joined_leagues = League.for_user(current_user).includes(:tournaments)
  end
  
  # return "active" if the user is on the page of param "league". 
  # Useful for the left side menu.
  def is_league_active(league)
    return "active" if controller_name == 'leagues' and @league and @league.id == league.id
  end
  
  # return "active" if the user is on the page of param "tournament".
  # Useful for the left side menu.
  def is_tournament_active(tournament)
    return "active" if controller_name == 'tournaments' and @tournament and @tournament.id = tournament.id 
  end
  
  # Check if the param "game" is past (so the user can't edit his guess).
  def is_past_game(game)
    DateTime.now > game.kickoff_at
  end
  
  # return: 
  #  0 if the result and guess are different
  #  1 if the winning team is correct (or draw)
  #  3 if the result matches the guess
  def getPoints(result, guess)
    return 0 if guess.empty? or guess == "-" or guess == "n/a"
    
    if result == guess
      3
    elsif winning_team(result) == winning_team(guess)
      1
    else
      0
    end
  end
  
  # Return which team won the game (or draw)
  def winning_team(result)
    goals = result.split("-")
    if goals[0] == goals[1]
      "draw"
    elsif goals[0].to_i > goals[1].to_i
      "home"
    else
      "away"
    end
  end
  
  # return the boostrap class for a badge
  def getBadgeClass(result, guess)
    point = getPoints(result, guess)
    if point == 3
      "badge-success"
    elsif point == 1
      "badge-primary"
    else
      "badge-default"
    end
  end
  
end
