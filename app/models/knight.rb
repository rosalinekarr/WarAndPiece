class Knight < Piece

  def valid_move?(new_file, new_rank)
    # checks to see if move is on the board
    return false if !super(new_file, new_rank)
    # checks to see if change in rank is equal to change in file, or if either change in file or change in rank are 0.
    return false if (new_file - self.file).abs == (new_rank - self.rank).abs || new_file - self.file == 0 || new_rank - self.rank == 0
    # checks to see if new square is at an appropriate distance
    new_file - self.file).abs <= 2 && (new_rank - self.rank).abs <= 2  
  end
  
end