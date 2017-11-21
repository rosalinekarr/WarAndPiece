class Piece < ApplicationRecord
  has_many :moves
  belongs_to :game
  belongs_to :user

  scope :black, -> { where(color: 'black') }
  scope :white, -> { where(color: 'white') }

  def white?
    color == 'white'
  end

  def black?
    color == 'black'
  end

  validates :rank, presence: true, numericality: (1..8)
  validates :file, presence: true, numericality: (1..8)

  def current_position
    {self.file => self.rank}
  end

  def valid_move?(new_file, new_rank)
    return false unless move_on_the_board?(new_file, new_rank)
  
    if is_capturing?(new_file, new_rank)
      return false unless is_capture_opposing_color?(new_file, new_rank)
    end

    return false if is_obstructed?(new_file, new_rank)

    true
  end

  def move_on_the_board?(new_file, new_rank)
    new_file >= 1 && new_file <= 8 && new_rank >= 1 && new_rank <= 8
  end

  def is_capturing?(new_file, new_rank)
    Piece.where(file: new_file, rank: new_rank, is_captured: false, game: game).present?
  end

  def is_capture_opposing_color?(file, rank)
    piece = Piece.where(file: file, rank: rank, is_captured: false, game: game).first
    if piece && self.color != piece.color
      true
    else
      false
    end
  end

  def is_obstructed?(col, row)     
    return false if type == "Knight"
                                ## pass in rank and file of the square we want to move to
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
    return false unless valid_move?(new_col, new_row)
    current_col = self.file
    current_row = self.rank
    pieces = Piece.where(file: new_col, rank: new_row, game: game, is_captured: false)
    if is_capturing?(new_col,new_row)
      captured_piece = pieces.first
      captured_piece.update(is_captured: true)
    end
    self.update(file: new_col, rank: new_row)
  end
end
