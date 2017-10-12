class Piece < ApplicationRecord
  has_many :moves
  belongs_to :black_player
  belongs_to :white_player
end
