require 'rails_helper'

RSpec.describe Game, type: :model do

  describe ".populate_board" do

    before do
      @game = FactoryGirl.create(:game)
    end

    it "creates pieces in specific positions" do

      piece_positions = []
      ['Rook', 'Knight', 'Bishop', 'Queen', 'King', 'Bishop', 'Knight', 'Rook'].each.with_index(1) do |piece, i|
        piece_positions << { type: piece,   file: i, rank: 1, game: @game,  color: 'white' }
        piece_positions << { type: piece,   file: i, rank: 8, game: @game, user: @game.black_player, color: 'black' }
      end

      1.upto(8).each do |column|
        piece_positions << { type: 'Pawn', file: column, rank: 2, game: @game,  color: 'white' }
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

  describe '.check?' do

    before do
      @game = FactoryGirl.create(:game)
    end

    context "game is in check" do
      xit 'is checked by Pawn on two-square first move' do
        @king = FactoryGirl.create(:king, game: @game, file: 5, rank: 5, color: :black_player_id)
        @pawn = FactoryGirl.create(:pawn, game: @game, file: 4, rank: 2,  color: :white_player_id)

        @pawn.move_to!(4, 4)
        result = @game.check?(@pawn)

        expect(result).to be true
      end

      xit 'is checked by Pawn on one-square move' do
        @king = FactoryGirl.create(:king, game: @game, file: 5, rank: 4, color: :black_player_id)
        @pawn = FactoryGirl.create(:pawn, game: @game, file: 4, rank: 2, color: :white_player_id)

        @pawn.move_to!(4, 3)
        result = @game.check?(@pawn)

        expect(result).to be true
      end

      it 'is checked by Rook' do
        @king = FactoryGirl.create(:king,  game: @game, file: 4, rank: 4, color: :black_player_id)
        @rook = FactoryGirl.create(:rook, game: @game, file: 1, rank: 1, color: :white_player_id)

        @rook.move_to!(4, 1)
        result = @game.check?(@rook)

        expect(result).to be true
      end

      it 'is checked by Knight' do
        @king = FactoryGirl.create(:king,  game: @game, file: 4, rank: 4, color: :black_player_id)
        @knight = FactoryGirl.create(:knight, file: 1, rank: 1, game: @game, color: :white_player_id)

        @knight.move_to!(3, 2)
        result = @game.check?(@knight)

        expect(result).to be true
      end

      it 'is checked by Queen' do
        @king = FactoryGirl.create(:king,  game: @game, file: 4, rank: 4, color: :black_player_id)
        @queen = FactoryGirl.create(:queen, game: @game, file: 2, rank: 1, color: :white_player_id)

        @queen.move_to!(1, 1)
        result = @game.check?(@queen)

        expect(result).to be true
      end

      it 'is checked by Bishop' do
        @king = FactoryGirl.create(:king,  game: @game, file: 4, rank: 4, color: :black_player_id)
        @bishop = FactoryGirl.create(:bishop, game: @game, file: 5, rank: 7, color: :white_player_id)

        @bishop.move_to!(6, 6)
        result = @game.check?(@bishop)

        expect(result).to be true
      end
    end

    context "invalid case" do
      xit 'is not checked by Pawn on two-square first move' do
        @king = FactoryGirl.create(:king, game: @game, file: 5, rank: 5, color: :black_player_id)
        @pawn = FactoryGirl.create(:pawn, game: @game, file: 5, rank: 2, color: :white_player_id)

        @pawn.move_to!(5, 4)
        result = @game.check?(@pawn)

        expect(result).to be false
      end

      xit 'is not checked by Pawn on one-square move' do
        @king = FactoryGirl.create(:king, game: @game, file: 5, rank: 4, color: :black_player_id)
        @pawn = FactoryGirl.create(:pawn, game: @game, file: 5, rank: 2, color: :white_player_id)

        @pawn.move_to!(5, 3)
        result = @game.check?(@pawn)

        expect(result).to be false
      end

      it 'is not checked by Rook' do
        @king = FactoryGirl.create(:king,  game: @game, file: 4, rank: 4, color: :black_player_id)
        @rook = FactoryGirl.create(:rook, game: @game, file: 1, rank: 1,  color: :white_player_id)

        @rook.move_to!(1, 3)
        result = @game.check?(@rook)

        expect(result).to be false
      end

      it 'is not checked by Knight' do
        @king = FactoryGirl.create(:king,  game: @game, file: 4, rank: 4, color: :black_player_id)
        @knight = FactoryGirl.create(:knight, game: @game, file: 2, rank: 1,  color: :white_player_id)

        @knight.move_to!(1, 3)
        result = @game.check?(@knight)

        expect(result).to be false
      end

      it 'is not checked by Queen' do
        @king = FactoryGirl.create(:king, game: @game, file: 4, rank: 4, color: :black_player_id)
        @queen = FactoryGirl.create(:queen, game: @game, file: 2, rank: 1, color: :white_player_id)

        @queen.move_to!(2, 3)
        result = @game.check?(@queen)

        expect(result).to be false
      end

      it 'is not checked by Bishop' do
        @king = FactoryGirl.create(:king, game: @game, file: 4, rank: 4, color: :black_player_id)
        @bishop = FactoryGirl.create(:bishop, game: @game, file: 1, rank: 3, color: :white_player_id)

        @bishop.move_to!(2, 4)
        result = @game.check?(@bishop)

        expect(result).to be false
      end
    end
  end 

  describe ".checkmate?" do

    before do
      @game = FactoryGirl.create(:game)
    end

    context "when valid" do
      it "is checkmate when all of king's valid moves result in check" do
        @black_king = FactoryGirl.create(:king, file: 5, rank: 5, game: @game, color: 'black')
        @white_king = FactoryGirl.create(:king, file: 4, rank: 7, game: @game, color: 'white')
        @white_queen = FactoryGirl.create(:queen, file: 4, rank: 1, game: @game, color: 'white')
        @white_rook = FactoryGirl.create(:rook, file: 2, rank: 4, game: @game, color: 'white')
        @white_knight = FactoryGirl.create(:knight, file: 8, rank: 6, game: @game, color: 'white')
        @attacking_piece = FactoryGirl.create(:bishop, file: 3, rank: 1, game: @game, color: 'white')

        @attacking_piece.move_to!(2, 2)
        result = @game.checkmate?(@attacking_piece)

        expect(result).to be true
      end
    end

    context "when not valid" do
      it "is not checkmate when king can move to non-check square"

      it "is not checkmate when king captures a piece to escape check"

      it "is not checkmate when opposing player obstructs attacking piece"
    end

  end
end
