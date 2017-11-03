class Queen < Piece

  # file and rank where piece is trying to move
  def valid_move?(new_file, new_rank)
    # checks to see if move is on the board
    if method(:valid_move?).super_method.call(new_file, new_rank)
      true
    # checks to make sure move is on the board
    elsif new_file < 1 || new_file > 8 || new_rank < 1 || new_rank > 8
      'Not Valid'
    # checks to see if change in rank is equal to change in file, or if either change in file or change in rank are 0.
    elsif (new_file - self.file).abs == (new_rank - self.rank).abs || new_file - self.file == 0 || new_rank - self.rank == 0
      true
    else
      'Not Valid'
    end
  end  

end