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

  describe ".turn?" do
    let(:game) { FactoryGirl.create :game }
    let(:white_piece) { FactoryGirl.create :piece, file: 4, rank: 2, game: game, color: :white_player_id }
    let(:black_piece) { FactoryGirl.create :piece, file: 4, rank: 7, game: game, color: :black_player_id }

    it "assigns the first turn to the white_player" do
      ## no move yet
      expect(game.white_player.turn?).to be true
    end
    it "prevents the opposing player from moving when it is not their turn" do
      ## first turn
      black_piece.move_to!(4, 5)
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "changes after a player has moved" do
      white_piece.move_to!(4, 4)
      expect(game.white_player.turn?).to be false
      expect(game.black_player.turn?).to be true
    end
  end

end
