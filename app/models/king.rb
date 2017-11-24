# Logic for King piece
class King < Piece
  # file and rank where piece is trying to move
  def valid_move?(new_file, new_rank)
    return false unless super(new_file, new_rank)
    # checks to make sure move is not greater than 1
    if (new_file - file).abs <= 1 && (new_rank - rank).abs <= 1
      true
    else
      false
    end
  end

  def get_valid_moves
    valid_moves = []

    adjacent_files = (self.file-1..self.file+1)
    adjacent_ranks = (self.rank-1..self.rank+1)

    adjacent_files.each do |column|
      adjacent_ranks.each do |row|
        if valid_move?(column, row)
          valid_moves << [column, row]
        end
      end
    end

    valid_moves
  end

end
