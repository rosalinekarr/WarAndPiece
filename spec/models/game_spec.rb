require 'rails_helper'

RSpec.describe Game, type: :model do

  describe ".populate_board" do

    before do
      @game = FactoryGirl.create(:game)
    end

    it "creates pieces in specific positions" do

      piece_positions = []
      ['Rook', 'Knight', 'Bishop', 'Queen', 'King', 'Bishop', 'Knight', 'Rook'].each.with_index(1) do |piece, i|
        piece_positions << { type: piece,   file: i, rank: 1, game: @game, user: @game.white_player, color: 'white' }
        piece_positions << { type: piece,   file: i, rank: 8, game: @game, user: @game.black_player, color: 'black' }
      end

      1.upto(8).each do |column|
        piece_positions << { type: 'Pawn', file: column, rank: 2, game: @game, user: @game.white_player, color: 'white' }
        piece_positions << { type: 'Pawn', file: column, rank: 7, game: @game, user: @game.black_player, color: 'black' }
      end

      @game.populate_board

      piece_positions.each do |piece|
        expect(Piece.exists?(piece)).to eq(true)
      end

    end

    it "creates a specific number of types per color" do

      number_of_chess_types = {
        'Rook': 2,
        'Knight': 2,
        'Bishop': 2,
        'Queen': 1,
        'King': 1,
        'Pawn': 8
      }

      @game.populate_board

      number_of_chess_types.each do |piece, number|
        expect(Piece.where(type: piece, color:'white').count).to eq(number)
        expect(Piece.where(type: piece, color:'black').count).to eq(number)
      end

    end
  end

  describe "game#check determines if the king is in check" do

    before do
      @game = FactoryGirl.build(:game)
      @king = FactoryGirl.create(:piece, file: 4, rank: 4, game: @game, color: :black_player_id)
      @piece = FactoryGirl.create(:piece, file: 5, rank: 5, game: @game, color: :white_player_id)
    end

    it "checks that the king is not the same color as the piece" do
      expect(@king.color == @piece.color).to be false
    end
    it "checks that the piece could move to the square where the king is" do
      expect(@piece.valid_move?(4, 4)).to eq true
    end
  end
end
