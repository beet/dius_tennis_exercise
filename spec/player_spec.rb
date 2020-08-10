require "spec_helper"

describe Player do
  let(:name) { "Arjun Hirthe" }

  subject(:player) { Player.new(name) }

  context "#name" do
    it "is the player's name" do
      expect(player.name).to eq(name)
    end
  end

  context "#points" do
    it "is 0 initially" do
      expect(player.points).to eq(0)
    end
  end

  context "#score_point" do
    before do
      player.score_point
    end

    it "increments the player's points by 1" do
      expect(player.points).to eq(1)
    end
  end

  context ">= comparisons" do
    before do
      allow(player).to receive_messages(points: points)
    end

    context "between a player with 2 points and a score of 3" do
      let(:points) { 2 }
      let(:score) { 3 }

      it "is false" do
        expect(player >= score).to be_falsey
      end
    end

    context "between a player with 3 points and a score of 3" do
      let(:points) { 3 }
      let(:score) { 3 }

      it "is true" do
        expect(player >= score).to be_truthy
      end
    end

    context "between a player with 4 points and a score of 3" do
      let(:points) { 4 }
      let(:score) { 3 }

      it "is true" do
        expect(player >= score).to be_truthy
      end
    end

    context "between a player with 3 points and a score of 4" do
      let(:points) { 3 }
      let(:score) { 4 }

      it "is false" do
        expect(player >= score).to be_falsey
      end
    end

    context "between a player with 4 points and a score of 4" do
      let(:points) { 4 }
      let(:score) { 4 }

      it "is true" do
        expect(player >= score).to be_truthy
      end
    end

    context "between a player with 5 points and a score of 4" do
      let(:points) { 5 }
      let(:score) { 4 }

      it "is true" do
        expect(player >= score).to be_truthy
      end
    end
  end
end
