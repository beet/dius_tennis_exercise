class Match
  attr_reader :player_1_name, :player_2_name, :games

  def initialize(player_1_name, player_2_name)
    @player_1_name = player_1_name
    @player_2_name = player_2_name
    @games = []
  end

  def point_won_by(name)
    current_game.point_won_by(name)
  end

  def score
    [game_scores, match_score].compact.join(", ")
  end

  private

  def current_game
    games.detect(&:active?) || start_new_game.last
  end

  def start_new_game
    @games << Game.new(player_1_name, player_2_name)
  end

  def game_scores
    scores.join(", ")
  end

  def scores
    games.map(&:score)
  end

  def match_score
    "Match #{winning_player_name}" if has_winner?
  end

  def has_winner?
    match_point? || tie_breaker?
  end

  def match_point?
    max_wins >= 6 && wins_delta >= 2
  end

  def max_wins
    player_wins.max
  end

  def wins_delta
    player_wins.reduce(&:-).abs
  end

  def player_wins
    [player_1_wins, player_2_wins]
  end

  def player_1_wins
    games.select { |game| game.won_by?(player_1_name)}.size
  end

  def player_2_wins
    games.select { |game| game.won_by?(player_2_name)}.size
  end

  # TODO: implement tie-break rules
  def tie_breaker?
    false
  end

  def winning_player_name
    player_1_wins == max_wins ? player_1_name : player_2_name
  end
end
