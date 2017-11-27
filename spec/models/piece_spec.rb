require 'rails_helper'

RSpec.describe Piece, type: :model do

  describe "piece#move_on_the_board?" do
    before(:each) do
      @game = FactoryGirl.build(:game)
    end

    it "should return true if piece is on the board" do
      @piece = FactoryGirl.create(:piece, file: 1, rank: 2, game: @game)
      expect(@piece.move_on_the_board?(1,3)).to eq(true)
    end

    it "should return false if piece is not on the board" do
      @piece = FactoryGirl.create(:piece, file: 1, rank: 2, game: @game)
      expect(@piece.move_on_the_board?(1, -1)).to eq(false)
    end
  end

  describe "piece#is_capturing?" do
    before do
      @game = FactoryGirl.create(:game)
    end

    it "is capturing" do
      @piece = FactoryGirl.create(:piece, file: 4, rank: 4, game: @game)
      @capture_piece = FactoryGirl.create(:piece, file: 5, rank: 5, game: @game)

      result = @piece.is_capturing?(@capture_piece.file, @capture_piece.rank)

      expect(result).to be true
    end

    it "is not capturing" do
      @piece = FactoryGirl.create(:piece, file: 4, rank: 4, game: @game)
      empty_file = 5
      empty_rank = 5

      result = @piece.is_capturing?(empty_file, empty_rank)

      expect(result).to be false
    end
  end

  describe "piece#is_capture_opposing_color?" do

    before do
      @game = FactoryGirl.create(:game)
    end

    context "valid case" do
      it "when moving to an opposing color's position" do
        @white_piece = FactoryGirl.create(:piece, file: 4, rank: 4, color: 'white', game: @game)
        @black_piece = FactoryGirl.create(:piece, file: 5, rank: 5, color: 'black', game: @game)

        result = @white_piece.is_capture_opposing_color?(@black_piece.file, @black_piece.rank)

        expect(result).to be true
      end
    end

    context "invalid case" do
      it "when moving to a same color position" do
        @white_piece = FactoryGirl.create(:piece, file: 1, rank: 1, color: 'white', game: @game)
        @same_color_piece = FactoryGirl.create(:piece, file: 2, rank: 2, color: 'white', game: @game)
        
        result = @white_piece.is_capture_opposing_color?(@same_color_piece.file, @same_color_piece.rank)

        expect(result).to be false
      end

      it "when moving to an empty position" do
        @white_piece = FactoryGirl.create(:piece, file: 1, rank: 1, color: 'white', game: @game)
        empty_position_file = 2
        empty_position_rank = 2

        result = @white_piece.is_capture_opposing_color?(empty_position_file, empty_position_rank)

        expect(result).to be false
      end
    end

  end

  describe ".valid_move? validates piece move positions" do

    before do
      @game = FactoryGirl.create(:game)
    end

    context "valid move" do
      it "when moving inside the board" do
        @piece = FactoryGirl.create(:piece, file: 1, rank: 1, game: @game)
        new_file = 2
        new_rank = 2

        result = @piece.valid_move?(new_file, new_rank)

        expect(result).to be true
      end

      it "when moving to an opposing piece position" do
        @white_piece = FactoryGirl.create(:piece, file: 1, rank: 1, color: 'white', game: @game)
        @black_piece = FactoryGirl.create(:piece, file: 2, rank: 2, color: 'black', game: @game)

        result = @white_piece.valid_move?(@black_piece.file, @black_piece.rank)

        expect(result).to be true
      end
    end

    context "invalid move" do
      it "when moving off the board" do
        @piece = FactoryGirl.create(:piece, file: 1, rank: 1, game: @game)
        invalid_file = -1
        invalid_rank = -1

        result = @piece.valid_move?(invalid_file, invalid_rank)

        expect(result).to be false
      end

      it "when moving to a same color piece position" do
        @white_piece = FactoryGirl.create(:piece, file: 1, rank: 1, color: 'white', game: @game)
        @same_color_piece = FactoryGirl.create(:piece, file: 2, rank: 2, color: 'white', game: @game)
        
        result = @white_piece.valid_move?(@same_color_piece.file, @same_color_piece.rank)

        expect(result).to be false
      end

      it "when moving in place" do
        @piece = FactoryGirl.create(:piece, file: 1, rank: 1, game: @game)

        result = @piece.valid_move?(@piece.file, @piece.rank)

        expect(result).to be false
      end

    end
  end

  describe "piece#is_obstructed? checks if there is an obstruction between two squares" do

    before(:each) do
      @game = FactoryGirl.build(:game)
      @current_square = FactoryGirl.create(:piece, file: 4, rank: 4, game: @game)
    end

    it "Knight never is obstructed" do
      knight = FactoryGirl.create(:piece, type: "Knight", file: 2, rank: 1, game: @game)
      FactoryGirl.create(:piece, file: 2, rank: 2, game: @game)
      expect(knight.is_obstructed?(1, 3)).to be false
    end

    it "checks if there is no obstruction" do
      FactoryGirl.create(:piece, file: 6, rank: 6, game: @game)
      expect(@current_square.is_obstructed?(5, 5)).to be false
    end

    it "checks if there is an obstruction horizontally to the right" do
      FactoryGirl.create(:piece, file: 5, rank: 4, game: @game)
      expect(@current_square.is_obstructed?(6, 4)).to be true
    end
    it "checks if there is an obstruction horizontally to the left" do
      FactoryGirl.create(:piece, file: 3, rank: 4, game: @game)
      expect(@current_square.is_obstructed?(2, 4)).to be true
    end

    it "checks if there is an obstruction vertically above" do
      FactoryGirl.create(:piece, file: 4, rank: 5, game: @game)
      expect(@current_square.is_obstructed?(4, 6)).to be true
    end
    it "checks if there is an obstruction vertically below" do
      FactoryGirl.create(:piece, file: 4, rank: 3, game: @game)
      expect(@current_square.is_obstructed?(4, 2)).to be true
    end

    it "checks if there is an obstruction diagonally top-right" do
      FactoryGirl.create(:piece, file: 5, rank: 5, game: @game)
      expect(@current_square.is_obstructed?(6, 6)).to be true
    end
    it "checks if there is an obstruction diagonally bottom-right" do
      FactoryGirl.create(:piece, file: 5, rank: 3, game: @game)
      expect(@current_square.is_obstructed?(6, 2)).to be true
    end
    it "checks if there is an obstruction diagonally bottom-left" do
      FactoryGirl.create(:piece, file: 3, rank: 3, game: @game)
      expect(@current_square.is_obstructed?(2, 2)).to be true
    end
    it "checks if there is an obstruction diagonally top-left" do
      FactoryGirl.create(:piece, file: 3, rank: 5, game: @game)
      expect(@current_square.is_obstructed?(2, 6)).to be true
    end
  end

  describe "piece#get_path_between" do
    it "returns a valid path if both are directionally in line" do
      piece1 = Piece.new(file: 1, rank: 1)
      piece2 = Piece.new
      horizontal = [3, 1]
      vertical = [1, 3]
      diagonal = [3, 3]
      valid_paths = [ horizontal, vertical, diagonal ]
      
      valid_paths.each do |position|
        piece2.attributes = {file: position[0], rank: position[1]}
        result = piece1.get_path_between(piece2.file, piece2.rank)
        expect(result).not_to be_empty
      end
    end

    it "returns no valid path if both are not directionally in line" do
      piece1 = Piece.new(file: 1, rank: 1)
      piece2 = Piece.new
      invalid_paths = [ [3, 2], [2, 3], [7,8] ]
      
      invalid_paths.each do |position|
        piece2.attributes = {file: position[0], rank: position[1]}
        result = piece1.get_path_between(piece2.file, piece2.rank)
        expect(result).to be_nil
      end
    end
  end

  describe "piece#get_path_between_vertical" do
    it "returns the path between 2 pieces top to bottom" do
      @top_piece = Piece.new(file: 1, rank: 8)
      @bottom_piece = Piece.new(file:1, rank: 1)
      top_bottom_path = [ [1,7] , [1,6] ,[1,5] ,[1,4] ,[1,3] ,[1,2] ]

      result = @top_piece.get_path_between_vertical(@bottom_piece.file, @bottom_piece.rank)

      expect(result).to eq(top_bottom_path)
    end

    it "returns the path between 2 pieces bottom to top" do
      @bottom_piece = Piece.new(file:1, rank: 1)
      @top_piece = Piece.new(file: 1, rank: 8)
      bottom_top_path = [ [1,2] , [1,3] ,[1,4] ,[1,5] ,[1,6] ,[1,7] ]

      result = @bottom_piece.get_path_between_vertical(@top_piece.file, @top_piece.rank)

      expect(result).to eq(bottom_top_path)
    end
  end

  describe "piece#get_path_between_horizontal" do
    it "returns the path between 2 pieces left to right" do
      @left_piece = Piece.new(file: 1, rank: 1)
      @right_piece = Piece.new(file:8, rank: 1)
      left_right_path = [ [2,1] , [3,1] ,[4,1] ,[5,1] ,[6,1] ,[7,1] ]

      result = @left_piece.get_path_between_horizontal(@right_piece.file, @right_piece.rank)

      expect(result).to eq(left_right_path)
    end
    it "returns the path between 2 pieces right to left" do
      @right_piece = Piece.new(file:8, rank: 1)
      @left_piece = Piece.new(file: 1, rank: 1)
      right_left_path = [ [7,1] , [6,1] ,[5,1] ,[4,1] ,[3,1] ,[2,1] ]
      
      result = @right_piece.get_path_between_horizontal(@left_piece.file, @left_piece.rank)

      expect(result).to eq(right_left_path)
    end
  end

  describe "piece#get_path_between_diagonal" do
    it "returns the path between 2 pieces bottom-left to upper-right" do
      @bottom_left_piece = Piece.new(file: 1, rank: 1)
      @upper_right_piece = Piece.new(file:8, rank: 8)
      bleft_uright_path = [ [2,2] ,[3,3] ,[4,4] ,[5,5] ,[6,6], [7,7] ]

      result = @bottom_left_piece.get_path_between_diagonal(
                  @upper_right_piece.file, @upper_right_piece.rank
               )

      expect(result).to eq(bleft_uright_path)      
    end
    it "returns the path between 2 pieces upper-right to bottom-left" do
      @upper_right_piece = Piece.new(file:8, rank: 8)
      @bottom_left_piece = Piece.new(file: 1, rank: 1)
      uright_bleft_path = [ [7,7] ,[6,6] ,[5,5] ,[4,4] ,[3,3], [2,2] ]

      result = @upper_right_piece.get_path_between_diagonal(
                  @bottom_left_piece.file, @bottom_left_piece.rank
               )

      expect(result).to eq(uright_bleft_path) 
    end
    it "returns the path between 2 pieces upper-left to bottom-right" do
      @upper_left_piece = Piece.new(file: 1, rank: 8)
      @bottom_right_piece = Piece.new(file:8, rank: 1)
      uleft_bright_path = [ [2,7] ,[3,6] ,[4,5] ,[5,4] ,[6,3], [7,2] ]

      result = @upper_left_piece.get_path_between_diagonal(
                  @bottom_right_piece.file, @bottom_right_piece.rank
               )

      expect(result).to eq(uleft_bright_path)  
    end
    it "returns the path between 2 pieces bottom-right to upper-left" do
      @bottom_right_piece = Piece.new(file:8, rank: 1)
      @upper_left_piece = Piece.new(file: 1, rank: 8)
      bright_uleft_piece = [ [7,2] ,[6,3] ,[5,4] ,[4,5] ,[3,6], [2,7] ]

      result = @bottom_right_piece.get_path_between_diagonal(
                  @upper_left_piece.file, @upper_left_piece.rank
               )

      expect(result).to eq(bright_uleft_piece)  
    end
  end

  describe "piece#move_to! captures piece in new square if piece is the opposite color" do

    context "valid case" do
      before(:each) do
        @game = FactoryGirl.build(:game)
        @current_piece = FactoryGirl.create(:piece, file: 4, rank: 4, game: @game, color: :black_player_id)
        @next_square = FactoryGirl.create(:piece, file: 5, rank: 5, game: @game, color: :white_player_id)
        @king = FactoryGirl.create(:king, game: @game, color: "black")
      end

      it "checks that there is a piece in the new square" do
        expect(@next_square.blank?).to be false
      end
      it "checks that the piece in the new square belongs to the current game" do
        expect(@next_square.game == @game).to be true
      end
      it "checks that the piece in the new square has not already been captured" do
        expect(@next_square[:is_captured]).to be false
      end
      it "checks that the piece is the opposite color" do
        expect(@next_square.color == @current_piece.color).to be false
      end
      it "captures a piece" do
        @current_piece.move_to!(5, 5)
        @next_square.reload
        expect(@next_square[:is_captured]).to be true
      end
      it "updates the coordinates of the piece that did the capturing" do
        @current_piece.move_to!(5, 5)
        expect(@current_piece.file).to eq 5
        expect(@current_piece.rank).to eq 5
      end
    end

    context "invalid case" do
      before(:each) do
        @game = FactoryGirl.build(:game)
        @current_piece = FactoryGirl.create(:piece, file: 4, rank: 4, game: @game, color: 'white')
        @piece_same_color = FactoryGirl.create(:piece, file: 5, rank: 5, game: @game, color: 'white')
      end

      it "does not move to own-piece square" do
        @current_piece.move_to!(5, 5)

        expect(@current_piece.file).to eq(4)
        expect(@current_piece.rank).to eq(4)
      end

      it "does not capture own piece" do
        @current_piece.move_to!(5, 5)
        @piece_same_color.reload

        expect(@piece_same_color.is_captured).to be false
      end
    end
  end

end


  # it "is valid with valid attributes" do
  #   piece = FactoryGirl.create(:piece)

  #   expect(piece).to be_valid
  # end

  # it "without a type" do
  #   piece = FactoryGirl.create(:piece, type: "")

  #   expect(piece).to_not be_valid
  # end

  # it "is a valid type" do
  #   piece = FactoryGirl.create(:piece, type: "pawn")

  #   expect(piece.type).to eq("pawn")
  # end

  # it "if it is an invalid type" do
  #   piece = FactoryGirl.create(:piece, type: "invalid_type")

  #   expect(piece).to_not be_valid
  # end

  # it "is valid with a user" do
  #   piece = FactoryGirl.create(:piece, user: User.create( email:"test@email.com",
  #                                                         password:"secret",
  #                                                         password_confirmation: "secret"))
  #   expect(piece).to be_valid
  # end

  # it "without a user" do
  #   piece = FactoryGirl.create(:piece, user: "")

  #   expect(piece).to_not be_valid
  # end

  # it "without a rank" do
  #   piece = FactoryGirl.create(:piece, rank: "")

  #   expect(piece).to_not be_valid
  # end

  # it "is valid with a integers 1-8 as the rank" do
  #   piece = FactoryGirl.create(:piece)

  #   1.upto(8). do |value|
  #     piece.rank = value
  #     expect(piece).to be_valid
  #   end
  # end

  # it "with any rank not between integers 1-8" do
  #   piece = FactoryGirl.create(:piece)
  #   invalid_integers = [-1, 9, 100, 1000]

  #   invalid_integers.each do |invalid_integer|
  #     piece.typ = invalid_type
  #     expect(piece).to_not be valid
  #   end
  # end

  # it "with a non-integer value for the rank" do
  #   piece = FactoryGirl.create(:piece)
  #   invalid_types = ['a',"rank1", true, 1.5, {a:1}]

  #   invalid_types.each do |invalid_type|
  #     piece.type = invalid_type
  #     expect(piece).to_not be valid
  #   end
  # end

  # it "without a file" do
  #   piece = FactoryGirl.create(:piece, file:"")

  #   expect(piece).to_not be_valid
  # end

  # it "is valid with the letters a-f as the file" do
  #   piece = FactoryGirl.create(:piece)
  #   valid_files = (a..f).to_a

  #   valid_files.each do |valid_file|
  #     piece.file = valid_file
  #     expect(piece).to be_valid
  #   end

  # end

  # it "with an invalid file value" do
  #   piece = FactoryGirl.create(:piece)
  #   invalid_files = ['g',"file_a", true, 1.5, {file:a}]

  #   invalid_files.each do |invalid_file|
  #     piece.file = invalid_file
  #     expect(piece).to_not be_valid
  #   end
  # end

  # it "is valid when not is_captured" do
  #    piece = FactoryGirl.create(:piece, is_captured: false)

  #    expect(piece).to be_valid
  # end

  # it "without an is_captured status" do
  #   piece = FactoryGirl.create(:piece, is_captured: nil)

  #   expect(piece).to_not be_valid
  # end

  # it "is not captured when initially created" do
  #   piece = FactoryGirl.create(:piece, is_captured: true)

  #   expect(piece).to_not be_valid
  # end
