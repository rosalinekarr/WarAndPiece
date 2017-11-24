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
        @king_valid_moves = [ [1, 1], [1, 2], [1, 3], [2, 1],
                              [2, 3], [3, 1], [3, 2], [3, 3] ]
                              
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
      it "returns valid moves that do not place king in check"
    end
    
  end

end
