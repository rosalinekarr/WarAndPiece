require 'rails_helper'

RSpec.describe Game, type: :model do
  it "should populate the board with pieces when started" do
    game = FactoryGirl.create(:game)
    expect(game.pieces.count).to eq 32
  end
end
