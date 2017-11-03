require 'rails_helper'

RSpec.describe Queen, type: :model do
  
  describe 'queen#valid_move? checks if the queen is making a valid move' do
    before(:each) do
      @game = FactoryGirl.build(:game)
    end
    
    it 'should return true for valid vertical move' do
      @queen = FactoryGirl.create(:queen, file: 1, rank: 2, game: @game)
      expect(@queen.valid_move?(1, 4)).to eq(true)
    end
    it 'should return true for valid horizontal move' do
      @queen = FactoryGirl.create(:queen, file: 1, rank: 2, game: @game)
      expect(@queen.valid_move?(5, 2)).to eq(true)
    end
    it 'should Not Valid false for invalid move down' do
      @queen = FactoryGirl.create(:queen, file: 1, rank: 1, game: @game)
      expect(@queen.valid_move?(1, -1)).to eq('Not Valid')
    end
    it 'should return true for valid move diagonally' do
      @queen = FactoryGirl.create(:queen, file: 2, rank: 2, game: @game)
      expect(@queen.valid_move?(4, 4)).to eq(true)
    end
    it 'should return Not Valid for move off board' do
      @king = FactoryGirl.create(:queen, file: 1, rank: 1, game: @game)
      expect(@queen.valid_move?(1, 0)).to eq('Not Valid')
    end
  end
end