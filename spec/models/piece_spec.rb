require 'rails_helper'

RSpec.describe Piece, type: :model do

  describe "piece#is_obstructed? checks if there is an obstruction between two squares" do

    before(:each) do
      @current_square = FactoryGirl.build(:piece, rank: 4, file: 4)
    end
    
    it "checks if there is no obstruction" do
      obstruction = FactoryGirl.build(:piece, rank: 6, file: 6)
      expect(@current_square.is_obstructed?(5, 5)).to be false
    end

    it "checks if there is an obstruction horizontally to the right" do
      obstruction = FactoryGirl.build(:piece, rank: 4, file: 5)
      expect(@current_square.is_obstructed?(4, 6)).to be true
    end
    it "checks if there is an obstruction horizontally to the left" do
      obstruction = FactoryGirl.build(:piece, rank: 4, file: 3)
      expect(@current_square.is_obstructed?(4, 2)).to be true
    end

    it "checks if there is an obstruction vertically above" do
      obstruction = FactoryGirl.build(:piece, rank: 5, file: 4)
      expect(@current_square.is_obstructed?(6, 4)).to be true
    end
    it "checks if there is an obstruction vertically below" do
      obstruction = FactoryGirl.build(:piece, rank: 3, file: 4)
      expect(@current_square.is_obstructed?(2, 4)).to be true
    end

    it "checks if there is an obstruction diagonally top-right" do
      obstruction = FactoryGirl.build(:piece, rank: 5, file: 5)
      expect(@current_square.is_obstructed?(6, 6)).to be true
    end
    it "checks if there is an obstruction diagonally bottom-right" do
      obstruction = FactoryGirl.build(:piece, rank: 3, file: 5)
      expect(@current_square.is_obstructed?(2, 6)).to be true
    end
    it "checks if there is an obstruction diagonally bottom-left" do
      obstruction = FactoryGirl.build(:piece, rank: 3, file: 3)
      expect(@current_square.is_obstructed?(2, 2)).to be true
    end
    it "checks if there is an obstruction diagonally top-left" do
      obstruction = FactoryGirl.build(:piece, rank: 5, file: 3)
      expect(@current_square.is_obstructed?(6, 2)).to be true
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
