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
    
    valid_moves_before_capturing = []
    opposing_piece_adjacent = Piece.new
    opposing_team = self.game.pieces.where.not(color: self.color).where(is_captured: false)
    opposing_team.each do |piece|
      if piece.valid_move?(column, row)
        valid_moves_before_capturing << [column, row]
      end

      if piece.file == column && piece.rank == row
        opposing_piece_adjacent = piece
      end
    end

    valid_moves_after_capturing = []
    unless opposing_piece_adjacent.type.nil?
      puts "#{opposing_piece_adjacent.type} is potential king capture piece!"
      opposing_piece_adjacent.is_captured = true
      opposing_piece_adjacent.save
    
      opposing_team = self.game.pieces.where.not(color: self.color).where(is_captured: false)
      opposing_team.each do |piece|
        if piece.valid_move?(column, row)
          valid_moves_after_capturing << [column, row]
        end
      end

      opposing_piece_adjacent.is_captured = false
      opposing_piece_adjacent.save
    end

    puts ""
    puts ""
    puts "position at #{column}, #{row}"
    puts "#{valid_moves_before_capturing} moves before capture state"
    puts "#{valid_moves_after_capturing} moves after capture state"



    if valid_moves_before_capturing.empty? && valid_moves_after_capturing.empty?
      puts "king can escape here"
      false
    else
      puts "king is in check here"
      true
    end

  end

end
