class Game < ApplicationRecord
  belongs_to :black_player
  belongs_to :white_player
  has_many :pieces
end
