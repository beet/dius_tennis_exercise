# DiUS Tennis Exercise submission - Mark Beattie

I love these programming exercises, the last one I did was a ten pin bowling game scoring system, which I was able to implement for all but a perfect game of strikes.

I managed to get the basic tennis game working with a couple of POROs. A `Player` object holds the name and points scored by each player, and encapsulates logic for comparing their points with a given score.

The `Player` object holds their points, and instances are comparable allowing for things like `player1 > player2`.

The `Game` object implements `#point_won_by` which takes a player's name as per the specs, and provides `#score` which returns a string like "40-15", "Advantage player 1", or ultimately "Game player 1". The `TieBreaker` sub-class implements different scoring logic for tie-breaker games, where the points increment by 1 instead of 0-15-30 etc. which continues until one player wins seven points by a margin of two or more points.

The `Match` object as specified only considers there to be one set, and encapsulates the logic for a player winning the match by having won at least 6 games, and at least 2 games more than the opponent, as well as the special tie-break logic.

## Installation

* Create a gemset
* `bundle install` for RSpec

## Usage

To verify that it can score the given example tennis game correctly, run the specs:

    bundle exec rspec spec/

Output:

```
Game
  #point_won_by
    scores a point for the player of the given name
  #score
    when players 1 and 2 have scored one point each
      is 15-15
      then player 1 then wins two more points
        is 40-15
        then player 2 then wins the next two points
          is Deuce
          then player 1 takes the next point
            is advantage player 1
            and player 1 takes another point
              is game player 1
    when there is more than a 2 point difference between players
      correctly identifies the winning player
  active?
    when the game has a winner
      is false
    when the game does not have a winner
      is true
  won_by?
    when the game has a winner
      when given the leaging player's name
        is true
      when not given the leading player's name
        is false
    when the game does not have a winner
      is false

Match
  #score
    when player 1 smashes player 2 by 6 games to 0
      is match player 1
    when player 1 is winning 6 games to 5
      an additional game must be played
      and the leading player (player 1) wins the 7th game
        is match player 1
      and the trailing player (player 2) wins the 7th game (taking the score to 6 games to 6)
        goes to a tie-breaker
        and player 1 is leading player 2 in the tie-breaker by 6 points to 5
          goes to another game
          and player 1 wins game 7
            is match player 1

Player
  #name
    is the player's name
  #points
    is 0 initially
  #score_point
    increments the player's points by 1
  >= comparisons
    between a player with 2 points and a score of 3
      is false
    between a player with 3 points and a score of 3
      is true
    between a player with 4 points and a score of 3
      is true
    between a player with 3 points and a score of 4
      is false
    between a player with 4 points and a score of 4
      is true
    between a player with 5 points and a score of 4
      is true

TieBreaker
  #score
    when player 1 smashes player 2 by 7 points to 0
      is game player 1
    when player 1 is leading player 2 by 7 points to 6
      is 7-6
      if player 1 wins another point, taking them to a 8-6 lead
        is game player 1
      if player 2 wins another point
        is 7-7
        if player 1 wins 2 more points
          is game player 1
        if player 2 wins 2 more points
          is game player 2
```
