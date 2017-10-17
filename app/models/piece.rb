class Piece < ApplicationRecord
  has_many :moves
  belongs_to :game
  belongs_to :black_player
  belongs_to :white_player

  def is_obstructed(row, col)    ## rank and file of the square we want to move to
    Piece.game.pieces each do |p|
      if p.rank == row && p.file == col
        return true
      else
        false
      end
    end
  end

end
