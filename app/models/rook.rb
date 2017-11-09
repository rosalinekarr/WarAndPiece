# /app/models/rook.rb

class Rook < Piece

  def valid_move?(new_file, new_rank)
    # checks that move is on the board
    return false if !super(new_file, new_rank)
    # checks that move is vertical or horizontal
    return true if self.file == new_file || self.rank == new_rank
    # any other move returns:
    false
  end

end