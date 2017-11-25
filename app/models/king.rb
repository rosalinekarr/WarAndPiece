# Logic for King piece
class King < Piece
  # file and rank where piece is trying to move
  def valid_move?(new_file, new_rank)
    return false unless super(new_file, new_rank)
    # checks to make sure move is not greater than 1
    if (new_file - file).abs <= 1 && (new_rank - rank).abs <= 1
      true
    else
      false
    end
  end

  def get_valid_moves
    valid_moves = []

    adjacent_files = (self.file-1..self.file+1)
    adjacent_ranks = (self.rank-1..self.rank+1)

    adjacent_files.each do |column|
      adjacent_ranks.each do |row|
        if valid_move?(column, row)
          valid_moves << [column, row] unless move_into_check_position?(column, row)
        end
      end
    end

    valid_moves
  end

  def move_into_check_position?(column, row)
    opposing_piece_adjacent = set_king_capture_piece_off_on(column, row)
    opposing_team = self.game.pieces.where.not(color: self.color).where(is_captured: false)
    opposing_team.each do |piece|
      if piece.valid_move?(column, row)
        set_king_capture_piece_off_on(column, row) if opposing_piece_adjacent
        return true
      end
    end
    
    set_king_capture_piece_off_on(column, row)
    false
  end

  def set_king_capture_piece_off_on(column, row)
    opposing_piece_adjacent = self.game.pieces.where(file: column, rank: row).where.not(color: self.color).first
    
    if opposing_piece_adjacent
      if opposing_piece_adjacent.is_captured
        opposing_piece_adjacent.is_captured = false
      else  
        opposing_piece_adjacent.is_captured = true
      end
      opposing_piece_adjacent.save
    end
    
    opposing_piece_adjacent
  end

end
