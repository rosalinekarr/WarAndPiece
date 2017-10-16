require 'rails_helper'

RSpec.describe Piece, type: :model do

  describe "piece#is_obstructed checks if there is an obstruction between two squares" do
    it "checks if there is an obstruction horizontally" do
      current_square = Piece.create(rank: 2, file: 2)
      previous_column_square = Piece.create(rank: 2, file: 1)
      next_column_square = Piece.create(rank: 2, file: 3)
      expect(current_square.is_obstructed).to be true
    end

    it "checks if there is an obstruction vertically" do
      current_square = Piece.create(rank: 2, file: 2)
      previous_row_square = Piece.create(rank: 1, file: 2)
      next_row_square = Piece.create(rank: 3, file: 2)
      expect(current_square.is_obstructed).to be true
    end

    it "checks if there is an obstruction diagonally" do
      current_square = Piece.create(rank: 2, file: 2)
      top_left_square = Piece.create(rank: 3, file: 1)
      top_right_square = Piece.create(rank: 3, file: 3)
      bottom_right_square = Piece.create(rank: 1, file: 3)
      bottom_left_square = Piece.create(rank: 1, file: 1)
      expect(current_square.is_obstructed).to be true
    end
  end

end
