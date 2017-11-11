class Bishop < Piece
  def valid_move?(new_file, new_rank)
    return false if !super(new_file, new_rank)
    (new_file - self.file).abs == (new_rank - self.rank).abs
  end
end
