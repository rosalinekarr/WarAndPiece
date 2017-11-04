class Pawn < Piece
 # file and rank where piece is trying to move
 
  def first_move?
    WHITE  && rank == 2 || BLACK && rank == 7
  end
   
  def valid_move?(new_file, new_rank)
    return 'Not Valid' if super(new_file, new_rank) == false
     # allows two forward spaces if first move
    if first_move?
      return 'Not Valid'unless new_file == file
        (BLACK && rank - new_rank == 1 || rank - new_rank == 2) ||
        (WHITE && new_rank - rank == 1 || new_rank - rank == 2)
    # checks to make sure move is not greater than 1 forward
    elsif !first_move?
        BLACK && (rank - new_rank) == 1 ||
        WHITE && (new_rank - rank) == 1
    # capture
    ((new_file - file) == 1 && (new_rank - rank) == 1)
      true
    else
      'Not Valid'
    end
  end
end
