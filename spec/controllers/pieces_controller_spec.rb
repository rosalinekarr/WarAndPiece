require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

  before(:each) do
    @game = FactoryGirl.create(:game)
    @piece = FactoryGirl.create(:piece, type: nil, game: @game, color: :white_player_id)
    @king = FactoryGirl.create(:king, game: @game, color: :black_player_id)
  end
  let(:game) { FactoryGirl.create :game }
  let(:white_piece) { FactoryGirl.create :piece, file: 4, rank: 2, game: game, color: :white_player_id }
  let(:black_piece) { FactoryGirl.create :piece, file: 4, rank: 7, game: game, color: :black_player_id }

  def update_xy
    patch :update, params: { id: @piece.id, piece: { file: 3, rank: 3}}
  end

  describe "pieces#update" do
    it "updates the file and rank of the chess piece when moved" do
      sign_in @piece.user
      update_xy
      @piece.reload
      expect(@piece.file).to eq 3
      expect(@piece.rank).to eq 3
    end
    it "does not let players who don't own a piece update it" do
      player = FactoryGirl.create(:user)
      sign_in player
      update_xy
      expect(response).to have_http_status(:forbidden)
    end
    it "creates a move model on update" do
      sign_in @piece.user
      update_xy
      expect(@piece.moves.length).to eq 1
      expect(@piece.moves.last.file).to eq 3
      expect(@piece.moves.last.rank).to eq 3
    end
    it "does not update the database when not valid" do
      sign_in @piece.user
      patch :update, params: { id: @piece.id, piece: { file: 'huh', rank: 'nope'}}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "assigns the first turn to the white_player" do
      #game begins, default turn should be true/white_player
      black_piece.move_to!(4, 5)
      expect(response).to have_http_status(:forbidden)    ## TEST FAILS; status is :ok (200)
    end
    it "prevents the opposing player from moving when it is not their turn" do
      white_piece.move_to!(4, 4)
      white_piece.reload
      white_piece.move_to!(4, 5)
      expect(response).to have_http_status(:forbidden)    ## TEST FAILS; status is :ok (200)
    end
  end

end
