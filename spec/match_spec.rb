require "spec_helper"

RSpec.describe Match do
  let(:player_1_name) { "Easter Hudson" }
  let(:player_2_name) { "Chyna Schiller" }

  subject(:match) { Match.new(player_1_name, player_2_name) }

  context "#score" do
    def give_game_to(player_name)
      4.times do
        match.point_won_by(player_name)
      end
    end

    context "when player 1 smashes player 2 by 6 games to 0" do
      before do
        6.times do
          give_game_to(player_1_name)
        end
      end

      it 'is match player 1' do
        expect(match.score).to eq(
          [
            "Game #{player_1_name}",
            "Game #{player_1_name}",
            "Game #{player_1_name}",
            "Game #{player_1_name}",
            "Game #{player_1_name}",
            "Game #{player_1_name}",
            "Match #{player_1_name}"
          ].join(", ")
        )
      end
    end

    context "when player 1 is winning 6 games to 5" do
      before do
        5.times do
          give_game_to(player_1_name)
          give_game_to(player_2_name)
        end

        give_game_to(player_1_name)
      end

      it 'an additional game must be played' do
        expect(match.score).to eq(
          [
            "Game #{player_1_name}",
            "Game #{player_2_name}",

            "Game #{player_1_name}",
            "Game #{player_2_name}",

            "Game #{player_1_name}",
            "Game #{player_2_name}",

            "Game #{player_1_name}",
            "Game #{player_2_name}",

            "Game #{player_1_name}",
            "Game #{player_2_name}",

            "Game #{player_1_name}"
          ].join(", ")
        )
      end

      context "and the leading player (player 1) wins the 7th game" do
        before do
          give_game_to(player_1_name)
        end

        it 'is match player 1' do
          expect(match.score).to eq(
            [
              "Game #{player_1_name}",
              "Game #{player_2_name}",

              "Game #{player_1_name}",
              "Game #{player_2_name}",

              "Game #{player_1_name}",
              "Game #{player_2_name}",

              "Game #{player_1_name}",
              "Game #{player_2_name}",

              "Game #{player_1_name}",
              "Game #{player_2_name}",

              "Game #{player_1_name}",
              "Game #{player_1_name}",

              "Match #{player_1_name}",
            ].join(", ")
          )
        end
      end

      context "and the trailing player (player 2) wins the 7th game (taking the score to 6 games to 6)" do
        before do
          give_game_to(player_2_name)
        end

        it "goes to a tie-breaker" do

          expect(match.score).to eq(
            [
              "Game #{player_1_name}",
              "Game #{player_2_name}",

              "Game #{player_1_name}",
              "Game #{player_2_name}",

              "Game #{player_1_name}",
              "Game #{player_2_name}",

              "Game #{player_1_name}",
              "Game #{player_2_name}",

              "Game #{player_1_name}",
              "Game #{player_2_name}",

              "Game #{player_1_name}",
              "Game #{player_2_name}",
            ].join(", ")
          )
        end

        context "and player 1 is leading player 2 in the tie-breaker by 6 points to 5" do
          before do
            5.times do
              match.point_won_by(player_1_name)
              match.point_won_by(player_2_name)
            end

            match.point_won_by(player_1_name)
          end

          it 'goes to another game' do
            expect(match.score).to eq(
              [
                "Game #{player_1_name}",
                "Game #{player_2_name}",

                "Game #{player_1_name}",
                "Game #{player_2_name}",

                "Game #{player_1_name}",
                "Game #{player_2_name}",

                "Game #{player_1_name}",
                "Game #{player_2_name}",

                "Game #{player_1_name}",
                "Game #{player_2_name}",

                "Game #{player_1_name}",
                "Game #{player_2_name}",

                "6-5"
              ].join(", ")
            )
          end

          context "and player 1 wins game 7" do
            before do
              match.point_won_by(player_1_name)
            end

            it 'is match player 1' do
              expect(match.score).to eq(
                [
                  "Game #{player_1_name}",
                  "Game #{player_2_name}",

                  "Game #{player_1_name}",
                  "Game #{player_2_name}",

                  "Game #{player_1_name}",
                  "Game #{player_2_name}",

                  "Game #{player_1_name}",
                  "Game #{player_2_name}",

                  "Game #{player_1_name}",
                  "Game #{player_2_name}",

                  "Game #{player_1_name}",
                  "Game #{player_2_name}",

                  "Game #{player_1_name}",
                  "Match #{player_1_name}"
                ].join(", ")
              )
            end
          end
        end
      end
    end
  end
end
