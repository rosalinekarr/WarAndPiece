class King < Piece
  def valid_move?(new_file, new_rank) #file and rank where piece is trying to move
    if new_file < 1 || new_file > 8 || new_rank < 1 || new_rank > 8 #checks to make sure move is on the board
      "Not Valid"
    elsif (new_file - file).abs <= 1 && (new_rank - rank).abs  <= 1 #checks to make sure move is not greater than 1
     true
    else
     "Not Valid"
    end
  end
end