require 'rails_helper'

RSpec.describe Piece, type: :model do
  # describe "piece#move_on_the_board?" do
  #  before(:each) do
  #    @game = FactoryGirl.build(:game)
  #    @piece = FactoryGirl.create(:piece, file: 4, rank: 4, game: @game)
  #  end
  #  it "should return true if piece is on the board" do
  #    @piece = FactoryGirl.create(:piece, file: 1, rank: 2, game: @game)
  #    expect(@piece.move_on_the_board?(1,3)).to eq(true)
  #  end
  #  it "should return Not Valid if piece is not on the board" do
  #    @piece = FactoryGirl.create(:piece, file: 1, rank: 2, game: @game)
  #    expect(@piece.move_on_the_board?(1, -1)).to eq(false)
  #  end
  # end

  describe "piece#is_obstructed? checks if there is an obstruction between two squares" do

    before(:each) do
      @game = FactoryGirl.build(:game)
      @current_square = FactoryGirl.create(:piece, file: 4, rank: 4, game: @game)
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

  describe "piece#move_to! captures piece in new square if piece is the opposite color" do

    context "valid case" do
      before(:each) do
        @game = FactoryGirl.build(:game)
        @current_piece = FactoryGirl.create(:piece, file: 4, rank: 4, game: @game, color: :black_player_id)
        @next_square = FactoryGirl.create(:piece, file: 5, rank: 5, game: @game, color: :white_player_id)
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

  # it "is not valid without a type" do
  #   piece = FactoryGirl.create(:piece, type: "")

  #   expect(piece).to_not be_valid
  # end

  # it "is a valid type" do
  #   piece = FactoryGirl.create(:piece, type: "pawn")

  #   expect(piece.type).to eq("pawn")
  # end

  # it "is not valid if it is an invalid type" do
  #   piece = FactoryGirl.create(:piece, type: "invalid_type")

  #   expect(piece).to_not be_valid
  # end

  # it "is valid with a user" do
  #   piece = FactoryGirl.create(:piece, user: User.create( email:"test@email.com",
  #                                                         password:"secret",
  #                                                         password_confirmation: "secret"))
  #   expect(piece).to be_valid
  # end

  # it "is not valid without a user" do
  #   piece = FactoryGirl.create(:piece, user: "")

  #   expect(piece).to_not be_valid
  # end

  # it "is not valid without a rank" do
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

  # it "is not valid with any rank not between integers 1-8" do
  #   piece = FactoryGirl.create(:piece)
  #   invalid_integers = [-1, 9, 100, 1000]

  #   invalid_integers.each do |invalid_integer|
  #     piece.typ = invalid_type
  #     expect(piece).to_not be valid
  #   end
  # end

  # it "is not valid with a non-integer value for the rank" do
  #   piece = FactoryGirl.create(:piece)
  #   invalid_types = ['a',"rank1", true, 1.5, {a:1}]

  #   invalid_types.each do |invalid_type|
  #     piece.type = invalid_type
  #     expect(piece).to_not be valid
  #   end
  # end

  # it "is not valid without a file" do
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

  # it "is not valid with an invalid file value" do
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

  # it "is not valid without an is_captured status" do
  #   piece = FactoryGirl.create(:piece, is_captured: nil)

  #   expect(piece).to_not be_valid
  # end

  # it "is not captured when initially created" do
  #   piece = FactoryGirl.create(:piece, is_captured: true)

  #   expect(piece).to_not be_valid
  # end
