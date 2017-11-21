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

    context "no adjacent pieces" do
      it "returns all 8 valid king moves" do
        @king = FactoryGirl.create(:king, file: 5, rank: 5)
        @king_valid_moves = [ {4=>4}, {4=>5}, {4=>6}, {5=>4},
                              {5=>6}, {6=>4}, {6=>5}, {6=>6} ]
                              
        result = @king.get_valid_moves

        expect(result).to eq(@king_valid_moves)
      end
    end

    context "adjacent pieces" do
      it "returns valid moves excluding same color piece positions"
      it "returns valid moves when opposing pieces are adjacent"
    end
      
    context "on game board edge" do
      it "returns valid moves when on edges"
    end
    
  end

end
