class Piece < ApplicationRecord
  has_many :moves
  belongs_to :game
  belongs_to :black_player
  belongs_to :white_player

  def is_obstructed

  end

end
