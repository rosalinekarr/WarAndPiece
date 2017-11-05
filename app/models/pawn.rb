# methods for Pawn piece
class Pawn < Piece
  def first_move?
    white? && rank == 2 || black? && rank == 7
  end

  def valid_move?(new_file, new_rank)
    return false unless super(new_file, new_rank)
    return false unless new_file == file

    if first_move?
      (black? && rank - new_rank == 1 || rank - new_rank == 2) ||
        (white? && new_rank - rank == 1 || new_rank - rank == 2)
    elsif !first_move?
      black? && (rank - new_rank) == 1 || white? && (new_rank - rank) == 1
    end
  end
end
