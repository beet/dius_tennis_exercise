=begin

A tie-break game continues until one player wins seven points by a margin of two or more points

=end
require "game"

class TieBreaker < Game
  def score
    winner_name || current_score
  end

  private

  def current_score
    "#{player_1.points}-#{player_2.points}"
  end

  def has_winner?
    any_player_has_7_points? && double_point_difference?
  end

  def any_player_has_7_points?
    players.select { |player| player.points >= 7}.any?
  end
end
