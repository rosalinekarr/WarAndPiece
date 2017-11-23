require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

  before(:each) do
    @game = FactoryGirl.create(:game)
    @piece = FactoryGirl.create(:piece, type: nil, game: @game, color: :white_player_id)
    @king = FactoryGirl.create(:king, game: @game, color: :black_player_id)
  end
  
  def update_xy
    patch :update, params: { id: @piece.id, piece: { file: 3, rank: 3}}, format: :js
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
      patch :update, params: { id: @piece.id, piece: { file: 'huh', rank: 'nope'}}, format: :js
      @piece.reload
      expect(@piece.rank).to eq 4
      expect(@piece.file).to eq 4    
    end
  end

end
