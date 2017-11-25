require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'pawn#valid_move?' do

    let(:game) { FactoryGirl.create :game }
    let(:white_pawn) { FactoryGirl.create :pawn, file: 1, rank: 2,
     color: 'white', game: game }
    let(:black_pawn) { FactoryGirl.create :pawn, file: 2, rank: 7,
     color: 'black', game: game}

    context 'when valid' do
      it 'is a forward move for the white_pawn' do
        expect(white_pawn.valid_move?(1, 4)).to eq(true)
      end
      it 'is a forward move for the black_pawn' do
        expect(black_pawn.valid_move?(2, 5)).to eq(true)
      end
    end
    context 'when not valid' do
      it 'is forbidden to move more than one square after initial pawn move' do
        @pawn =
          FactoryGirl.create(:pawn, file: 1, rank: 3, color: 'white', game: game)
        expect(white_pawn.valid_move?(1, 5)).to eq(false)
      end
      it 'is forbidden to move backward' do
        expect(black_pawn.valid_move?(2, 8)).to eq(false)
      end
    end
    context 'capture' do
      it 'is valid diagonally' do
        @pawn =
          FactoryGirl.create(:pawn, file: 1, rank: 6, color: 'white', game: game)
        expect(black_pawn.valid_move?(1, 6)).to eq(true)
      end
      it 'is not valid vertically' do
        @pawn =
          FactoryGirl.create(:pawn, file: 2, rank: 6, color: 'white', game: game)
        expect(black_pawn.valid_move?(2, 6)).to eq(false)
      end
    end
  end
end
