# methods for Pawn piece
class Pawn < Piece
  def first_move?
    white? && rank == 2 || black? && rank == 7
  end

  def backward_move?(new_rank)
    (black? && new_rank > rank) || (white? && new_rank < rank)
  end

  def valid_move?(new_file, new_rank)
    return false unless super(new_file, new_rank)
    return false unless new_file == file
    return false if backward_move?(new_rank)

    if first_move?
      (new_rank - rank).abs <= 2
    elsif !first_move?
      (new_rank - rank).abs <= 1
    end
  end
end
