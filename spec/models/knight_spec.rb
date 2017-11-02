require 'rails_helper'

RSpec.describe Knight, type: :model do
  
  before(:each) do
    @game = FactoryGirl.build(:game)
  end

  describe '#move_up_left?' do
    it 'is valid moving up and left' do
      knight = Knight.new(file: 4, rank: 5)
      file = 3
      rank = 7
      result = knight.move_up_left?(file, rank)

      expect(result).to eq(true)
    end

    xit 'is invalid moving up and left' do
      knight = Knight.new(file: 4, rank: 5)
      file = 4
      rank = 6

      result = knight.move_up_left?(file, rank)

      expect(result).to eq(false)
    end
  end

  describe '#move_up_right?' do
    xit 'is valid moving up and right' do
      knight = Knight.new(file: 4, rank: 5)
      file = 5
      rank = 7
      result = knight.move_up_right?(file, rank)

      expect(result).to eq(true)
    end

    xit 'is invalid moving up and right' do
      knight = Knight.new(file: 4, rank: 5)
      file = 4
      rank = 7

      result = knight.move_up_right?(file, rank)

      expect(result).to eq(false)
    end
  end  

  describe '#move_left_up?' do
    xit 'is valid moving left and up' do
      knight = Knight.new(file: 4, rank: 5)
      file = 2
      rank = 6
      result = knight.move_left_up?(file, rank)

      expect(result).to eq(true)
    end

    xit 'is invalid moving left and up' do
      knight = Knight.new(file: 4, rank: 5)
      file = 3
      rank = 5

      result = knight.move_left_up?(file, rank)

      expect(result).to eq(false)
    end
  end

  describe '#move_left_down?' do
    xit 'is valid moving left and down' do
      knight = Knight.new(file: 4, rank: 5)
      file = 2
      rank = 4
      result = knight.move_left_down?(file, rank)

      expect(result).to eq(true)
    end

    xit 'is invalid moving left and down' do
      knight = Knight.new(file: 4, rank: 5)
      file = 2
      rank = 5

      result = knight.move_left_down?(file, rank)

      expect(result).to eq(false)
    end
  end

  describe '#move_right_up?' do
    xit 'is valid moving right and up' do
      knight = Knight.new(file: 4, rank: 5)
      file = 6
      rank = 6
      result = knight.move_right_up?(file, rank)

      expect(result).to eq(true)
    end

    xit 'is invalid moving right and up' do
      knight = Knight.new(file: 4, rank: 5)
      file = 5
      rank = 5

      result = knight.move_right_up?(file, rank)

      expect(result).to eq(false)
    end
  end
    
  describe '#move_right_down?' do
    xit 'is valid moving right and down' do
      knight = Knight.new(file: 4, rank: 5)
      file = 6
      rank = 4
      result = knight.move_right_down?(file, rank)

      expect(result).to eq(true)
    end

    xit 'is invalid moving right and down' do
      knight = Knight.new(file: 4, rank: 5)
      file = 6
      rank = 5

      result = knight.move_right_down?(file, rank)

      expect(result).to eq(false)
    end
  end

  describe '#move_down_left?' do
    xit 'is valid moving down and left' do
      knight = Knight.new(file: 4, rank: 5)
      file = 3
      rank = 3
      result = knight.move_down_left?(file, rank)

      expect(result).to eq(true)
    end

    xit 'is invalid moving down and left' do
      knight = Knight.new(file: 4, rank: 5)
      file = 4
      rank = 4

      result = knight.move_down_left?(file, rank)

      expect(result).to eq(false)
    end
  end

  describe '#move_down_right?' do
    xit 'is valid moving down and right' do
      knight = Knight.new(file: 4, rank: 5)
      file = 5
      rank = 3
      result = knight.move_down_right?(file, rank)

      expect(result).to eq(true)
    end

    xit 'is invalid moving down and right' do
      knight = Knight.new(file: 4, rank: 5)
      file = 4
      rank = 3

      result = knight.move_down_right?(file, rank)

      expect(result).to eq(false)
    end
  end
end
