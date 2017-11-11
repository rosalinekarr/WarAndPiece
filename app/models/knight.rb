class Knight < Piece

  def valid_move?(new_file, new_rank)
    
    # validate move is within game board
    return false if !super(new_file, new_rank)

    move_up_left?(new_file, new_rank) ||
    move_up_right?(new_file, new_rank) ||
    move_down_left?(new_file, new_rank) ||
    move_down_right?(new_file, new_rank) ||
    move_left_up?(new_file, new_rank) ||
    move_left_down?(new_file, new_rank) ||
    move_right_up?(new_file, new_rank) ||
    move_right_down?(new_file, new_rank)
  end

  # validate move position against all 8 possible moves
  def move_up_left?(file, rank)
    (self.rank + 2 == rank) && (self.file - 1 == file)
  end

  def move_up_right?(file, rank)
    (self.rank + 2 == rank) && (self.file + 1 == file)
  end

  def move_down_left?(file, rank)
    (self.rank - 2 == rank) && (self.file - 1 == file)
  end

  def move_down_right?(file, rank)
    (self.rank - 2 == rank) && (self.file + 1 == file)
  end

  def move_left_up?(file, rank)
    (self.file - 2 == file) && (self.rank + 1 == rank)
  end

  def move_left_down?(file, rank)
    (self.file - 2 == file) && (self.rank - 1 == rank)
  end

  def move_right_up?(file, rank)
    (self.file + 2 == file) && (self.rank + 1 == rank)
  end

  def move_right_down?(file, rank)
    (self.file + 2 == file) && (self.rank - 1 == rank)
  end
end