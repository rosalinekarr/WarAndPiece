class Piece < ApplicationRecord
  has_many :moves
  belongs_to :game
  belongs_to :user

  def is_obstructed?(row, col)     ## pass in rank and file of the square we want to move to
    current_row = self.rank     ## rank of the Piece we're applying the method to
    current_col = self.file     ## file of the Piece we're applying the method to
    ranks = []
    files = []
    if current_col == col                                ## checks vertically
      if current_row < row                               ## above
        ranks = (current_row+1..row-1).map { |n| n = n }
      else                                               ## below
        ranks = (row+1..current_row-1).map { |n| n = n }
      end
      files = [col] * ranks.length
    elsif current_row == row                             ## checks horizontally
      if current_col < col                               ## to the right
        files = (current_col+1..col-1).map { |n| n = n }
      else                                               ## to the left
        files = (col+1..current_col-1).map { |n| n = n }
      end
      ranks = [row] * files.length
    elsif (row - current_row) == (col - current_col)      ## check diagonally
      if row - current_row > 0                            ## top-right
        ranks = (current_row+1..row-1).map { |n| n = n }
        files = (current_col+1..col-1).map { |n| n = n }
      else                                                ## bottom-left
        ranks = (row+1..current_row-1).map { |n| n = n }
        files = (col+1..current_col-1).map { |n| n = n }
      end
    else (row + col) == (current_row + current_col)
      if row > current_row                                ## top-left
        ranks = (current_row+1..row-1).map { |n| n = n }
        files = (col+1..current_col-1).map { |n| n = n }
      else                                                ## bottom-right
        ranks = (row+1..current_row-1).map { |n| n = n }
        files = (current_col+1..col-1).map { |n| n = n }
      end
    end
    # puts ranks.inspect
    # puts files.inspect
    # puts game.inspect
    # puts game.pieces.inspect
    game.pieces.each do |p|        ## MAKE THIS WORK! WHY ARE THERE NO PIECES TO LOOP THROUGH?
      # puts p.inspect
      if ranks.include?(p.rank) && files.include?(p.file)
        return true
      end
    end
    false
  end

end