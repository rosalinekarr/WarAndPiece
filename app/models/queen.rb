class Queen < Piece

  # file and rank where piece is trying to move
  def valid_move?(new_file, new_rank)
    # checks to see if move is on the board
    return false if !super(new_file, new_rank)
    # checks to see if change in rank is equal to change in file, or if either change in file or change in rank are 0.
    (new_file - self.file).abs == (new_rank - self.rank).abs || new_file - self.file == 0 || new_rank - self.rank == 0
  end  

end