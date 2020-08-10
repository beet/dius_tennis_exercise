class Player
  include Comparable

  attr_reader :name, :points

  def initialize(name)
    @name = name
    @points = 0
  end

  def score_point
    @points += 1
  end

  def <=>(score)
    points <=> score
  end
end
