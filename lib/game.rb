class Game
  SCORE_NAMES = %w(0 15 30 40)

  attr_reader :player_1, :player_2, :scores

  def initialize(player_1_name, player_2_name)
    @player_1 = Player.new(player_1_name)
    @player_2 = Player.new(player_2_name)
  end

  def point_won_by(name)
    find_player_by_name(name).score_point
  end

  def score
    winner_name || advantage_name || deuce || current_score
  end

  def active?
    !has_winner?
  end

  def won_by?(player_name)
    has_winner? && player_name == leading_player_name
  end

private

  def players
    [@player_1, @player_2]
  end

  def find_player_by_name(name)
    players.detect { |player| player.name == name}
  end

  def points_difference
    player_1.points - player_2.points
  end

  def points_difference_abs
    points_difference.abs
  end

  def single_point_difference?
    points_difference_abs == 1
  end

  def double_point_difference?
    points_difference_abs >= 2
  end

  def player_points
    players.map(&:points)
  end

  def any_player_has_4_points?
    players.detect { |player| player >= 4}
  end

  def highest_score
    player_points.max
  end

  def leading_player
    players.detect { |player| player.points == highest_score }
  end

  def leading_player_name
    leading_player.name
  end

  def three_points_scored_by_each_player?
    players.collect { |player| player >= 3 }.uniq == [true]
  end

  def scores_equal?
    player_points.uniq.size == 1
  end

  def player_score(player)
    SCORE_NAMES[player.points]
  end

  def winner_name
    "Game #{leading_player_name}" if has_winner?
  end

  def has_winner?
    any_player_has_4_points? && double_point_difference?
  end

  def advantage_name
    "Advantage #{leading_player_name}" if three_points_scored_by_each_player? && single_point_difference?
  end

  def deuce
    "Deuce" if three_points_scored_by_each_player? && scores_equal?
  end

  def current_score
    "#{player_score(player_1)}-#{player_score(player_2)}"
  end
end
