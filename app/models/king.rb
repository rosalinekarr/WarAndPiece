class King < Piece
  # file and rank where piece is trying to move
  def valid_move?(new_file, new_rank)
    # checks to make sure move is on the board
    if new_file < 1 || new_file > 8 || new_rank < 1 || new_rank > 8
      'Not Valid'
    # checks to make sure move is not greater than 1
    elsif (new_file - self.file).abs <= 1 && (new_rank - self.rank).abs <= 1
      true
    else
      'Not Valid'
    end
  end
end
