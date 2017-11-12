class Game < ApplicationRecord
  belongs_to :black_player, class_name: "User", foreign_key: "black_player_id", optional: true
  belongs_to :white_player, class_name: "User", foreign_key: "white_player_id"
  has_many :pieces

  scope :available, -> { where(black_player_id: nil)  }

  scope :inprogress, -> { where.not(black_player_id: nil) }

  def populate_board

    ['Rook', 'Knight', 'Bishop', 'Queen', 'King', 'Bishop', 'Knight', 'Rook'].each.with_index(1) do |piece, i|
      pieces.create!( type: piece,   file: i, rank: 1, user_id: white_player.id, color: 'white' )
      pieces.create!( type: piece,   file: i, rank: 8, user_id: black_player.id, color: 'black' )
    end

    1.upto(8).each do |column|
      pieces.create!( type: 'Pawn', file: column, rank: 2, user_id: white_player.id, color: 'white' )
      pieces.create!( type: 'Pawn', file: column, rank: 7, user_id: black_player.id, color: 'black' )
    end

  end

  def check(piece) # passes in piece that has just been moved
    King.where(game: @game) # database query for both king pieces in current game
    king_rank = self.rank
    king_file = self.file
    # if the King is a different color to the piece and the piece could capture the King
    if (self.color != piece.color) && piece.valid_move?(king_rank, king_file)
      true
    else
      false
    end
  end
end
