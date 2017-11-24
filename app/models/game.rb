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

  def check?(piece)
    king = King.where(game: piece.game).where.not(color: piece.color).first
    piece.valid_move?(king.file, king.rank)
  end

  def checkmate?(attacking_piece)

    checked_king = self.pieces.where(type:"King").where.not(color: attacking_piece.color).first
    king_moves = checked_king.get_valid_moves

    attack_team_pieces = self.pieces.where(color: attacking_piece.color, is_captured: false)

    king_moves.each do |move|
      king_file = move[0]
      king_rank = move[1]

      move_intersects = false    
      attack_team_pieces.each do |piece|
        if piece.valid_move?(king_file, king_rank)
          move_intersects = true 
          break
        end
      end


      unless move_intersects
        puts "DEBUG king can move to #{king_file}, #{king_rank}"
      end

      return false unless move_intersects
    end

    true
  end
end
