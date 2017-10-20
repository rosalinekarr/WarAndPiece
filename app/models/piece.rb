class Piece < ApplicationRecord
  has_many :moves
  belongs_to :game
  belongs_to :user

  def is_obstructed?(row, col)    ## rank and file of the square we want to move to
    
  end

end