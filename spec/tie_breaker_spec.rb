require "spec_helper"

RSpec.describe TieBreaker do
  let(:player_1_name) { "Katherine Breitenberg" }
  let(:player_2_name) { "Eden Bahringer" }

  subject(:game) { TieBreaker.new(player_1_name, player_2_name) }

  context "#score" do
    context "when player 1 smashes player 2 by 7 points to 0" do
      before do
        7.times do
          game.point_won_by(player_1_name)
        end
      end

      it 'is game player 1' do
        expect(game.score).to eq("Game #{player_1_name}")
      end
    end

    context "when player 1 is leading player 2 by 7 points to 6" do
      before do
        7.times do
          game.point_won_by(player_1_name)
        end

        6.times do
          game.point_won_by(player_2_name)
        end
      end

      it 'is 7-6' do
        expect(game.score).to eq("7-6")
      end

      context "if player 1 wins another point, taking them to a 8-6 lead" do
        before do
          game.point_won_by(player_1_name)
        end

        it 'is game player 1' do
          expect(game.score).to eq("Game #{player_1_name}")
        end
      end

      context "if player 2 wins another point" do
        before do
          game.point_won_by(player_2_name)
        end

        it 'is 7-7' do
          expect(game.score).to eq("7-7")
        end

        context "if player 1 wins 2 more points" do
          before do
            2.times do
              game.point_won_by(player_1_name)
            end
          end

          it 'is game player 1' do
            expect(game.score).to eq("Game #{player_1_name}")
          end
        end

        context "if player 2 wins 2 more points" do
          before do
            2.times do
              game.point_won_by(player_2_name)
            end
          end

          it 'is game player 2' do
            expect(game.score).to eq("Game #{player_2_name}")
          end
        end
      end
    end
  end
end
