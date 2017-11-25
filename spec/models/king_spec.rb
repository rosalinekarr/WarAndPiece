require 'rails_helper'

RSpec.describe King, type: :model do
  
  describe 'king#valid_move? checks if the king is making a valid move' do
    before(:each) do
      @game = FactoryGirl.build(:game)
    end
    
    it 'should return true for valid up move' do
      @king = FactoryGirl.create(:king, file: 1, rank: 2, game: @game)
      expect(@king.valid_move?(1, 3)).to eq(true)
    end
    it 'should return false for invalid move down' do
      @king = FactoryGirl.create(:king, file: 1, rank: 1, game: @game)
      expect(@king.valid_move?(1, -1)).to eq(false)
    end
    it 'should return true for valid move diagonally' do
      @king = FactoryGirl.create(:king, file: 2, rank: 2, game: @game)
      expect(@king.valid_move?(3, 3)).to eq(true)
    end
    it 'should return false for move off board' do
      @king = FactoryGirl.create(:king, file: 1, rank: 1, game: @game)
      expect(@king.valid_move?(1, 0)).to eq(false)
    end
  end

  describe '.get_valid_moves' do

    before do
      @game = FactoryGirl.create(:game)
    end
    
    context "no adjacent pieces" do
      it "returns all 8 valid king moves" do
        @king = FactoryGirl.create(:king, file: 5, rank: 5, game: @game)
        @king_valid_moves = [ [4, 4], [4, 5], [4, 6], [5, 4],
                              [5, 6], [6, 4], [6, 5], [6, 6] ]
                              
        result = @king.get_valid_moves

        expect(result).to eq(@king_valid_moves)
      end
    end

    context "adjacent pieces" do
      it "returns valid moves excluding same color piece positions" do
        @king = FactoryGirl.create(:king, file: 2, rank: 2, color: 'white', game: @game)
        1.upto(3) {|n| FactoryGirl.create(:pawn, file: n, rank: 3, color: 'white', game: @game) }
        @king_valid_moves = [ [1, 1], [1, 2], [2, 1], [3, 1], [3, 2] ]
                              
        result = @king.get_valid_moves

        expect(result).to eq(@king_valid_moves)
      end

      it "returns valid moves when opposing pieces are adjacent" do
        @king = FactoryGirl.create(:king, file: 2, rank: 2, color: 'white', game: @game)
        [:knight, :pawn, :knight].each.with_index(1) do |piece_type,i|
          FactoryGirl.create(piece_type, file: i, rank: 3, color: 'black', game: @game) 
        end                                         
        @king_valid_moves = [ [1,1], [1,3], [2,3], [3,1], [3,3] ]
                              
        result = @king.get_valid_moves

        expect(result).to eq(@king_valid_moves)
      end
    end
      
    context "on game board edge" do
      it "returns valid moves when on edges" do
        @king = FactoryGirl.create(:king, file: 1, rank: 1, game: @game) 
        @king_valid_moves = [ [1, 2], [2, 1], [2, 2] ]
                              
        result = @king.get_valid_moves

        expect(result).to eq(@king_valid_moves)
      end
    end

    context "moves that place king in check" do
      it "returns valid moves that do not place king in check" do
        @bishop1 = FactoryGirl.create(:bishop, file: 5, rank: 3, color: 'white', game: @game)
        @bishop2 = FactoryGirl.create(:bishop, file: 1, rank: 2, color: 'white', game: @game)
        @queen = FactoryGirl.create(:queen, file: 3, rank: 1, color: 'white', game: @game) 
        @knight = FactoryGirl.create(:knight, file: 1, rank: 4, color: 'white', game: @game)
        @white_king = FactoryGirl.create(:king, file: 6, rank: 4, color: 'white', game: @game)
        @rook = FactoryGirl.create(:rook, file: 8, rank: 5, color: 'white', game: @game)
        @black_king = FactoryGirl.create(:king, file: 4, rank: 4, color: 'black', game: @game) 
        @black_king_valid_moves = [ [4,3] ]
                              
        result = @black_king.get_valid_moves

        expect(result).to eq(@black_king_valid_moves)
      end
    end
      
  end

  describe '.move_into_check_position?(column, row)' do
    
    before do
      @game = FactoryGirl.create(:game)
    end
    
    it "is valid when King moves in an illegal check position" do
      @queen = FactoryGirl.create(:queen, file: 1, rank: 1, color: 'white', game: @game)
      @rook = FactoryGirl.create(:rook, file: 1, rank: 3, color: 'white', game: @game)
      @king = FactoryGirl.create(:king, file: 3, rank: 2, color: 'black', game: @game)
      @king_illegal_moves = [ [2,1], [2,2], [2,3], [3,1],
                              [3,3], [4,1], [4,3] ]

      @king_illegal_moves.each do |move|
        result = @king.move_into_check_position?(move[0], move[1])

        expect(result).to be true
      end
    end

    it "is invalid when King does not move into check position" do
      @queen = FactoryGirl.create(:queen, file: 1, rank: 1, game: @game)
      @rook = FactoryGirl.create(:rook, file: 1, rank: 3, game: @game)
      @king = FactoryGirl.create(:king, file: 3, rank: 2, game: @game)
      king_valid_file = 4
      king_valid_rank = 2

      result = @king.move_into_check_position?(king_valid_file, king_valid_rank)

      expect(result).to be false
    end
  
  end

end
