require 'rails_helper'

RSpec.describe Pawn, type: :model do
  
  describe 'pawn#valid_move? checks if the pawn is a valid move' do
    before(:each) do
      @game = FactoryGirl.build(:game)
    end
    
    it 'should return true for valid up move' do
      @pawn = FactoryGirl.create(:pawn, file: 1, rank: 2, color: 'white', game: @game)
      expect(@pawn.valid_move?(1, 4)).to eq(true)
    end
    it 'should return true for valid up move' do
      @pawn = FactoryGirl.create(:pawn, file: 1, rank: 2, color: 'white', game: @game)
      expect(@pawn.valid_move?(1, 3)).to eq(true)
    end
    it 'should return true for valid up move' do
      @pawn = FactoryGirl.create(:pawn, file: 1, rank: 3, color: 'white', game: @game)
      expect(@pawn.valid_move?(1, 5)).to eq('Not Valid')
    end
    it 'should Not Valid false for invalid move down' do
      @pawn = FactoryGirl.create(:pawn, file: 1, rank: 2, game: @game)
      expect(@pawn.valid_move?(1, 1)).to eq('Not Valid')
    end
    it 'should return true for valid move forward' do
      @pawn = FactoryGirl.create(:pawn, file: 2, rank: 7, color: 'black', game: @game)
      expect(@pawn.valid_move?(2, 5)).to eq(true)
    end
    it 'should return true for valid move forward' do
      @pawn = FactoryGirl.create(:pawn, file: 2, rank: 7, color: 'black', game: @game)
      expect(@pawn.valid_move?(2, 8)).to eq('Not Valid')
    end
    it 'should return Not Valid for move off board' do
      @pawn = FactoryGirl.create(:pawn, file: 1, rank: 1, game: @game)
      expect(@pawn.valid_move?(1, 0)).to eq('Not Valid')
    end
  end
end
