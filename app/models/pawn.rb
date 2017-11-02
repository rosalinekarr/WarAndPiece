class Pawn < Piece
 # file and rank where piece is trying to move
  def valid_move?(new_file, new_rank)
    # checks to make sure move is on the board
    if new_file < 1 || new_file > 8 || new_rank < 1 || new_rank > 8
      'Not Valid'
    # allows two forward spaces if first move  
    elsif Piece.moves.first(new_rank - self.rank) <= 2
      true
    # checks to make sure move is not greater than 1 forward or 1 diagonal 
    # for capture
    elsif (new_rank - self.rank) <= 1 || 
    # capture
    ((new_file - self.file) == 1 && (new_rank - self.rank) == 1)
      true
    else
      'Not Valid'
    end
  end
end
