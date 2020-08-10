# DiUS Tennis Exercise submission - Mark Beattie

I love these programming exercises, the last one I did was a ten pin bowling game scoring system, which I was able to implement for all but a perfect game of strikes.

I managed to get the basic tennis game working with a couple of POROs. A `Player` object holds the name and points scored by each player, and encapsulates logic for comparing their points with a given score.

The `Game` object implements `#point_won_by` which takes a player's name as per the specs, as opposed to an object ID or player number, and provides `#score` which returns a string like "40-15", "Advantage player 1", or ultimately "Game player 1". _(It uses the player's actual name for advantage/game, not "player 1/2")_

## Installation

* Create a gemset
* `bundle install` for RSpec

## Usage

To verify that it can score the given example tennis game correctly, run the specs:

    rspec spec --format documentation

Output:

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
