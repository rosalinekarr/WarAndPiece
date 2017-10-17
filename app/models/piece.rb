class Piece < ApplicationRecord
  has_many :moves
  belongs_to :game
  belongs_to :user
end
