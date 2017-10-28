require 'rails_helper'

RSpec.describe Game, type: :model do

  it ".populate_board" do
    
    game = FactoryGirl.create(:game)

    piece_positions = []
    ["Rook", "Knight", "Bishop", "Queen", "King", "Bishop", "Knight", "Rook"].each.with_index(1) do |piece, i|
      piece_positions << { type: piece,   file: i, rank: 1, game: game, user: game.white_player }
      piece_positions << { type: piece,   file: i, rank: 8, game: game, user: game.black_player }
    end

    1.upto(8).each do |column|
      piece_positions << { type: "Pawn", file: column, rank: 2, game: game, user: game.white_player }
      piece_positions << { type: "Pawn", file: column, rank: 7, game: game, user: game.black_player }
    end

    game.populate_board

    piece_positions.each do |piece|
      expect(Piece.exists?(piece)).to eq(true)
    end
  end
  
end
