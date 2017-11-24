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
    checked_king_team_pieces = self.pieces.where(color: checked_king.color, is_captured: false).where.not(type:"King")

    # check if defending team can capture attacking piece
    checked_king_team_pieces.each do |piece|
      return false if piece.valid_move?(attacking_piece.file, attacking_piece.rank)
    end

    attack_team_pieces = self.pieces.where(color: attacking_piece.color, is_captured: false)
    
    # check if defending team can obstruct
    check_between_path = checked_king.get_path_between(attacking_piece.file, attacking_piece.rank)
    if check_between_path
      puts "#{check_between_path.inspect}"
      check_between_path.each do |position|
        checked_king_team_pieces.each do |piece|
          return false if piece.valid_move?(position[0], position[1])
        end
      end
    end

    # check if king can/cannot escape with his valid moves
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
