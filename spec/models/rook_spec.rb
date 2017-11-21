require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe 'Rook#valid_move? checks if the Rook is making a valid move' do
    before(:each) do
      @game = FactoryGirl.build(:game)
      @rook = Rook.new(file: 1, rank: 1, game: @game)
    end
    it 'returns true for vertical move' do
      expect(@rook.valid_move?(1, 6)).to be true
    end
    it 'returns true for horizontal move' do
      expect(@rook.valid_move?(6, 1)).to be true
    end
    it 'returns false for diagonal move' do
      expect(@rook.valid_move?(3, 3)).to be false
    end
    it 'returns false for a non-linear move' do
      expect(@rook.valid_move?(7, 3)).to be false
    end
  end
end
