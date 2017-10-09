require 'rails_helper'

RSpec.describe Move, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:move)).to be_valid
  end
  # it "is invalid without a game_id" do
  #   expect(FactoryGirl.build(:move, game_id: nil).valid?).to be false
  # end
  # it "is invalid without a piece_id" do
  #   expect(FactoryGirl.build(:move, piece_id: nil).valid?).to be false
  # end
  # it "is invalid without a rank" do
  #   expect(FactoryGirl.build(:move, rank: nil).valid?).to be false
  # end
  # it "is invalid without a file" do
  #   expect(FactoryGirl.build(:move, file: nil).valid?).to be false
  # end
end