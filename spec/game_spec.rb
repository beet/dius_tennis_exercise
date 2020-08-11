require "spec_helper"

describe Game do
  let(:player_1_name) { "Vito Hackett" }
  let(:player_2_name) { "Bryana Frami" }

  subject(:game) { Game.new(player_1_name, player_2_name) }

  context "#point_won_by" do
    let(:player_1) { double(Player, name: player_1_name) }

    before do
      allow(Player).to receive(:new)

      allow(Player).to receive(:new)
        .with(player_1_name)
        .and_return(player_1)
    end

    it "scores a point for the player of the given name" do
      expect(player_1).to receive(:score_point)

      game.point_won_by(player_1_name)
    end
  end

  context "#score" do
    context "when players 1 and 2 have scored one point each" do
      before do
        game.point_won_by(player_1_name)
        game.point_won_by(player_2_name)
      end

      it "is 15-15" do
        expect(game.score).to eq("15-15")
      end

      context "then player 1 then wins two more points" do
        before do
          game.point_won_by(player_1_name)
          game.point_won_by(player_1_name)
        end

        it "is 40-15" do
          expect(game.score).to eq("40-15")
        end

        context "then player 2 then wins the next two points" do
          before do
            game.point_won_by(player_2_name)
            game.point_won_by(player_2_name)
          end

          it "is Deuce" do
            expect(game.score).to eq("Deuce")
          end

          context "then player 1 takes the next point" do
            before do
              game.point_won_by(player_1_name)
            end

            it "is advantage player 1" do
              expect(game.score).to eq("Advantage #{player_1_name}")
            end

            context "and player 1 takes another point" do
              before do
                game.point_won_by(player_1_name)
              end

              it "is game player 1" do
                expect(game.score).to eq("Game #{player_1_name}")
              end
            end
          end
        end
      end
    end

    context "when there is more than a 2 point difference between players" do
      before do
        4.times do
          game.point_won_by(player_1_name)
        end
      end

      it 'correctly identifies the winning player' do
        expect(game.score).to eq("Game #{player_1_name}")
      end
    end
  end

  context "active?" do
    before do
      allow(game).to receive(:has_winner?).and_return(has_winner)
    end

    context "when the game has a winner" do
      let(:has_winner) { true }

      it 'is false' do
        expect(game).to_not be_active
      end
    end

    context "when the game does not have a winner" do
      let(:has_winner) { false }

      it 'is true' do
        expect(game).to be_active
      end
    end
  end

  context "won_by?" do
    before do
      allow(game).to receive(:has_winner?).and_return(has_winner)
      allow(game).to receive(:leading_player_name).and_return(player_1_name)
    end

    context "when the game has a winner" do
      let(:has_winner) { true }

      context "when given the leaging player's name" do
        it 'is true' do
          expect(game.won_by?(player_1_name)).to be_truthy
        end
      end

      context "when not given the leading player's name" do
        it 'is false' do
          expect(game.won_by?(player_2_name)).to be_falsey
        end
      end
    end

    context "when the game does not have a winner" do
      let(:has_winner) { false }

      it 'is false' do
        expect(game.won_by?(player_1_name)).to be_falsey
      end
    end
  end
end
