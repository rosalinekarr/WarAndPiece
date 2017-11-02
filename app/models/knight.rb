class Knight < Piece

  def valid_move?(file, rank)
    
    if file < 1 || file > 8 || rank < 1 || rank > 8
      return false
    end

    move_up_left?(file, rank) ||
    move_up_right?(file, rank) ||
    move_down_left?(file, rank) ||
    move_down_right?(file, rank) ||
    move_left_up?(file, rank) ||
    move_left_down?(file, rank) ||
    move_right_up?(file, rank) ||
    move_right_down?(file, rank)
  end

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