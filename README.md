# DiUS Tennis Exercise submission - Mark Beattie

I love these programming exercises, the last one I did was a ten pin bowling game scoring system, which I was able to implement for all but a perfect game of strikes.

I managed to get the basic tennis game working with a couple of POROs. A `Player` object holds the name and points scored by each player, and encapsulates logic for comparing their points with a given score.

The `Game` object implements `#point_won_by` which takes a player's name as per the specs, as opposed to an object ID or player number, and provides `#score` which returns a string like "40-15", "Advantage player 1", or ultimately "Game player 1". _(It uses the player's actual name for advantage/game, not "player 1/2")_

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
      and the trailing player (player 2) wins the 7th game
        goes to a tie-breaker (PENDING: Not yet implemented)

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

Pending: (Failures listed here are expected and do not affect your suite's status)

  1) Match#score when player 1 is winning 6 games to 5 and the trailing player (player 2) wins the 7th game goes to a tie-breaker
     # Not yet implemented
     # ./spec/match_spec.rb:104
```

## Todo

- [ ] Implement tie-break rules

To implement tie-break rules, I'd create a sub-class of `Game` like `TieBreakGame` that overrides `has_winner?` with the tie-break logic of continuing until one player wins seven points by a margin of two or more points, and update `Match#start_new_game` to detect when it's in a tie-breaker and instantiate a `TieBreakGame` instead of a `Game` object.
