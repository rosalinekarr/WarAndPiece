class Piece < ApplicationRecord
  has_many :moves
  belongs_to :game
  belongs_to :user

  def is_obstructed?(row, col)    ## rank and file of the square we want to move to
    current_square_row = self.rank
    current_square_col = self.file
    # puts current_square_row.inspect
    # puts current_square_col.inspect
    between = []
    ranks = []
    files = []
    if current_square_col == col                ## checks vertically
      if current_square_row < row               ## above
        ranks = (current_square_row+1..row-1).map { |n| n = n }
        ranks.length.times { |n| files << col }
      else                                      ## below
        ranks = (row+1..current_square_row-1).map { |n| n = n }
        ranks.length.times { |n| files << col }
      end
    elsif current_square_row == row             ## checks horizontally
      if current_square_col < col               ## to the right
        files = (current_square_col+1..col-1).map { |n| n = n }
        files.length.times { |n| ranks << row }
      else                                      ## to the left
        files = (col+1..current_square_col-1).map { |n| n = n }
        files.length.times { |n| ranks << row }
      end
    elsif                                       ## check diagonally

    end
    between << ranks
    between << files
    puts between.inspect
  end

end