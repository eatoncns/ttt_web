require 'game_mode'

RSpec.describe GameMode do
  context "given hvh mode parameter" do
    let(:params) { { "mode" => "hvh" } }
    let(:mode) { GameMode.new(params) }

    it "returns human for player one type" do
      expect(mode.player_one_type).to eq GameMode::Human
    end

    it "returns human for player two type" do
      expect(mode.player_two_type).to eq GameMode::Human
    end

    describe "#computer_first?" do
      it "returns false" do
        expect(mode.computer_first?).to be false
      end
    end

    describe "#has_computer?" do
      it "returns false" do
        expect(mode.has_computer?).to be false
      end
    end
  end

  context "given hvc mode parameter" do
    let(:params) { { "mode" => "hvc" } }
    let(:mode) { GameMode.new(params) }

    it "returns human for player one type" do
      expect(mode.player_one_type).to eq GameMode::Human
    end

    it "returns computer for player two type" do
      expect(mode.player_two_type).to eq GameMode::Computer
    end

    describe "#computer_first?" do
      it "returns false" do
        expect(mode.computer_first?).to be false
      end
    end

    describe "#has_computer?" do
      it "returns true" do
        expect(mode.has_computer?).to be true
      end
    end
  end

  context "given cvh mode parameter" do
    let(:params) { { "mode" => "cvh" } }
    let(:mode) { GameMode.new(params) }

    it "returns computer for player one type" do
      expect(mode.player_one_type).to eq GameMode::Computer
    end

    it "returns human for player two type" do
      expect(mode.player_two_type).to eq GameMode::Human
    end

    describe "#computer_first?" do
      it "returns true" do
        expect(mode.computer_first?).to be true
      end
    end

    describe "#has_computer?" do
      it "returns true" do
        expect(mode.has_computer?).to be true
      end
    end
  end
end
