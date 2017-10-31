class Piece < ApplicationRecord
  has_many :moves
  belongs_to :game
  belongs_to :user

  def is_obstructed?(col, row)     ## pass in rank and file of the square we want to move to
    current_col = self.file     ## file of the Piece we're applying the method to
    current_row = self.rank     ## rank of the Piece we're applying the method to
    if current_row == row                                ## checks horizontally
      if current_col < col                               ## to the right
        files = (current_col+1..col-1).map { |n| n = n }
      else                                               ## to the left
        files = (col+1..current_col-1).map { |n| n = n }
      end
      ranks = [row] * files.length
    elsif  current_col == col                            ## checks vertically
      if current_row < row                               ## above
        ranks = (current_row+1..row-1).map { |n| n = n }
      else                                               ## below
        ranks = (row+1..current_row-1).map { |n| n = n }
      end
      files = [col] * ranks.length
    elsif (row - current_row) == (col - current_col)      ## check diagonally
      if (row - current_row) > 0                          ## top-right
        files = (current_col+1..col-1).map { |n| n = n }
        ranks = (current_row+1..row-1).map { |n| n = n }
      else                                                ## bottom-left
        files = (col+1..current_col-1).map { |n| n = n }
        ranks = (row+1..current_row-1).map { |n| n = n }
      end
    else (row + col) == (current_row + current_col)
      if row > current_row                                ## top-left
        files = (col+1..current_col-1).map { |n| n = n }
        ranks = (current_row+1..row-1).map { |n| n = n }
      else                                                ## bottom-right
        files = (current_col+1..col-1).map { |n| n = n }
        ranks = (row+1..current_row-1).map { |n| n = n }
      end
    end
    game.pieces.each do |p|
      if files.include?(p.file) && ranks.include?(p.rank)
        return true
      end
    end
    false
  end

  def move_to!(new_col, new_row)
    current_col = self.file
    current_row = self.rank
    pieces = Piece.where(file: new_col, rank: new_row, game: game, status: :onboard) # :onboard does not exist - consider if status necessary here, as :is_captured default is false 
      captured_piece = pieces.first # exists returns
      if self.color != captured_piece.color
        captured_piece.update(status: :is_captured)
        self.update(file: new_col, rank: new_row)
      else
      return 'Invalid move'
      end
    end
  end
end
