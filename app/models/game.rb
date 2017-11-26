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
    valid_king_moves = checked_king.get_valid_moves
    checked_king_team_pieces = self.pieces.where(color: checked_king.color, is_captured: false).where.not(type:"King")
    check_between_path = checked_king.get_path_between(attacking_piece.file, attacking_piece.rank)

    return false if defending_team_can_capture?(checked_king_team_pieces, attacking_piece)
    return false if defending_team_can_obstruct?(checked_king_team_pieces, check_between_path)
    return false unless valid_king_moves.empty?

    true
  end

  def defending_team_can_capture?(defending_team, attacking_piece)
    defending_team.each do |piece|
      return true if piece.valid_move?(attacking_piece.file, attacking_piece.rank)
    end
    false   
  end

  def defending_team_can_obstruct?(defending_team, check_between_path)
    unless check_between_path.blank?
      check_between_path.each do |position|
        defending_team.each do |piece|
          return true if piece.valid_move?(position[0], position[1])
        end
      end
    end
    false
  end

end
