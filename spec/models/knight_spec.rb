require 'rails_helper'

RSpec.describe Knight, type: :model do
  
  before(:each) do
    @game = FactoryGirl.build(:game)
  end

  describe '#valid_move?' do

    it 'is a valid knight move' do
      knight = Knight.new(file: 4, rank: 5)
      valid_knight_moves = [
        {3=>7},
        {5=>7},
        {2=>6},
        {2=>4},
        {6=>6},
        {6=>4},
        {3=>3},
        {5=>3}
      ]

      valid_knight_moves.each do |position|
        file = position.keys[0]
        rank = position.values[0]
        
        result = knight.valid_move?(file, rank)

        expect(result).to eq(true)
      end
    end

  end

  describe '#move_up_left?' do
    it 'is valid moving up and left' do
      knight = Knight.new(file: 4, rank: 5)
      file = 3
      rank = 7

      result = knight.move_up_left?(file, rank)

      expect(result).to eq(true)
    end

    it 'is invalid for moves other than rank+2 and file-1' do
      knight = Knight.new(file: 4, rank: 5)
      file = 4
      rank = 6

      result = knight.move_up_left?(file, rank)

      expect(result).to eq(false)
    end
  end

  describe '#move_up_right?' do
    it 'is valid moving up and right' do
      knight = Knight.new(file: 4, rank: 5)
      file = 5
      rank = 7

      result = knight.move_up_right?(file, rank)

      expect(result).to eq(true)
    end

    it 'is invalid for moves other than rank+2 and file+1' do
      knight = Knight.new(file: 4, rank: 5)
      file = 4
      rank = 7

      result = knight.move_up_right?(file, rank)

      expect(result).to eq(false)
    end
  end  

  describe '#move_left_up?' do
    it 'is valid moving left and up' do
      knight = Knight.new(file: 4, rank: 5)
      file = 2
      rank = 6

      result = knight.move_left_up?(file, rank)

      expect(result).to eq(true)
    end

    it 'is invalid for moves other than file-2 and rank+1' do
      knight = Knight.new(file: 4, rank: 5)
      file = 3
      rank = 5

      result = knight.move_left_up?(file, rank)

      expect(result).to eq(false)
    end
  end

  describe '#move_left_down?' do
    it 'is valid moving left and down' do
      knight = Knight.new(file: 4, rank: 5)
      file = 2
      rank = 4

      result = knight.move_left_down?(file, rank)

      expect(result).to eq(true)
    end

    it 'is invalid for moves other than file-2 and rank-1' do
      knight = Knight.new(file: 4, rank: 5)
      file = 2
      rank = 5

      result = knight.move_left_down?(file, rank)

      expect(result).to eq(false)
    end
  end

  describe '#move_right_up?' do
    it 'is valid moving right and up' do
      knight = Knight.new(file: 4, rank: 5)
      file = 6
      rank = 6

      result = knight.move_right_up?(file, rank)

      expect(result).to eq(true)
    end

    it 'is invalid for moves other than file+2 and rank+1' do
      knight = Knight.new(file: 4, rank: 5)
      file = 5
      rank = 5

      result = knight.move_right_up?(file, rank)

      expect(result).to eq(false)
    end
  end
    
  describe '#move_right_down?' do
    it 'is valid moving right and down' do
      knight = Knight.new(file: 4, rank: 5)
      file = 6
      rank = 4

      result = knight.move_right_down?(file, rank)

      expect(result).to eq(true)
    end

    it 'is invalid for moves other than file+2 and rank-1' do
      knight = Knight.new(file: 4, rank: 5)
      file = 6
      rank = 5

      result = knight.move_right_down?(file, rank)

      expect(result).to eq(false)
    end
  end

  describe '#move_down_left?' do
    it 'is valid moving down and left' do
      knight = Knight.new(file: 4, rank: 5)
      file = 3
      rank = 3

      result = knight.move_down_left?(file, rank)

      expect(result).to eq(true)
    end

    it 'is invalid for moves other than rank-2 and file-1' do
      knight = Knight.new(file: 4, rank: 5)
      file = 4
      rank = 4

      result = knight.move_down_left?(file, rank)

      expect(result).to eq(false)
    end
  end

  describe '#move_down_right?' do
    it 'is valid moving down and right' do
      knight = Knight.new(file: 4, rank: 5)
      file = 5
      rank = 3

      result = knight.move_down_right?(file, rank)

      expect(result).to eq(true)
    end

    it 'is invalid for moves other than rank-2 and file+1' do
      knight = Knight.new(file: 4, rank: 5)
      file = 4
      rank = 3

      result = knight.move_down_right?(file, rank)

      expect(result).to eq(false)
    end
  end
end
