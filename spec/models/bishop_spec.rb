require 'rails_helper'

 RSpec.describe Bishop, type: :model do

   describe 'bishop#valid_move? checks if the bishop is making a valid move' do
     before(:each) do
       @game = FactoryGirl.build(:game)
     end

     it 'should return false for invalid vertical move' do
       @bishop = FactoryGirl.create(:bishop, file: 4, rank: 4, game: @game)
       expect(@bishop.valid_move?(4, 5)).to eq(false)
     end
     it 'should return false for invalid horizontal move' do
       @bishop = FactoryGirl.create(:bishop, file: 4, rank: 4, game: @game)
       expect(@bishop.valid_move?(2, 4)).to eq(false)
     end
     it 'should return true for valid move diagonally' do
       @bishop = FactoryGirl.create(:bishop, file: 4, rank: 4, game: @game)
       expect(@bishop.valid_move?(2, 2)).to eq(true)
     end
     it 'should return false for invalid move' do
      @bishop = FactoryGirl.create(:bishop, file: 4, rank: 4, game: @game)
      expect(@bishop.valid_move?(5, 6)).to eq(false)
    end
   end
 end
