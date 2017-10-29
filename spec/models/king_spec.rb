require 'rails_helper'

RSpec.describe King, type: :model do
  
  describe "king#valid_move? checks if the king piece is making a valid move" do 
    before(:each) do
      @game = FactoryGirl.build(:game)
    end
    
    it "should return true for valid up move" do
      @king = FactoryGirl.create(:king, file: 1, rank: 2, game: @game)
      expect(@king.valid_move?(1,3)).to eq(true)
    end
    it "should Not Valid false for invalid move down" do
      @king = FactoryGirl.create(:king, file: 1, rank: 1, game: @game)
      expect(@king.valid_move?(1,-1)).to eq("Not Valid")
    end
    it "should return true for valid move diagonally" do
      @king = FactoryGirl.create(:king, file: 2, rank: 2, game: @game)
      expect(@king.valid_move?(3,3)).to eq(true)  
    end
    it "should return Not Valid for move off board" do
      @king = FactoryGirl.create(:king, file: 1, rank: 1, game: @game)
      expect(@king.valid_move?(1, 0)).to eq("Not Valid")
    end
  end
end