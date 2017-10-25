require 'rails_helper'

RSpec.describe Game, type: :model do

  it ".populate_board" do
    game = FactoryGirl.create(:game)

    game.populate_board

    expect(game.pieces.where(type:"Rook",   file:1, rank:1, user: game.white_player).count).to eq(1)
    expect(game.pieces.where(type:"Knight", file:2, rank:1, user: game.white_player).count).to eq(1)
    expect(game.pieces.where(type:"Bishop", file:3, rank:1, user: game.white_player).count).to eq(1)
    expect(game.pieces.where(type:"Queen",  file:4, rank:1, user: game.white_player).count).to eq(1)
    expect(game.pieces.where(type:"King",   file:5, rank:1, user: game.white_player).count).to eq(1)
    expect(game.pieces.where(type:"Bishop", file:6, rank:1, user: game.white_player).count).to eq(1)
    expect(game.pieces.where(type:"Knight", file:7, rank:1, user: game.white_player).count).to eq(1)
    expect(game.pieces.where(type:"Rook",   file:8, rank:1, user: game.white_player).count).to eq(1)

    1.upto(8).each do |column|
      expect(game.pieces.where(type:"Pawn",   file: column, rank:2, user: game.white_player).count).to eq(1)
      expect(game.pieces.where(type:"Pawn",   file: column, rank:7, user: game.black_player).count).to eq(1)
    end
  
    expect(game.pieces.where(type:"Rook",   file:1, rank:8, user: game.black_player).count).to eq(1)
    expect(game.pieces.where(type:"Knight", file:2, rank:8, user: game.black_player).count).to eq(1)
    expect(game.pieces.where(type:"Bishop", file:3, rank:8, user: game.black_player).count).to eq(1)
    expect(game.pieces.where(type:"Queen",  file:4, rank:8, user: game.black_player).count).to eq(1)
    expect(game.pieces.where(type:"King",   file:5, rank:8, user: game.black_player).count).to eq(1)
    expect(game.pieces.where(type:"Bishop", file:6, rank:8, user: game.black_player).count).to eq(1)
    expect(game.pieces.where(type:"Knight", file:7, rank:8, user: game.black_player).count).to eq(1)
    expect(game.pieces.where(type:"Rook",   file:8, rank:8, user: game.black_player).count).to eq(1)

    expect(game.pieces.count).to eq(32)
  end
  
end
