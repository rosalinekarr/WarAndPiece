class Pawn < Piece
 # file and rank where piece is trying to move
 
  def first_move?
    WHITE  && rank == 2 || BLACK && rank == 7
  end
   
  def valid_move?(new_file, new_rank)
    # checks to make sure move is on the board
    return 'Not Valid' if super(new_file, new_rank) == false
    # allows two forward spaces if first move  
      if first_move?
        
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
