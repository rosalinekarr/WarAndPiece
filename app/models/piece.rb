class Piece < ApplicationRecord
  has_many :moves
  belongs_to :game
  belongs_to :user

  def is_obstructed(row, col)    ## rank and file of the square we want to move to
    game.pieces.each do |p|     ## AS DEFINED IN CONTROLLER#???  or s.t. like Game.find(id)
      if p.rank == row && p.file == col
        return true
      end
    end
    false
  end

end