require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

  before(:each) do
    @piece = FactoryGirl.create(:piece)    
  end

  def update_xy
    patch :update, params: { id: @piece.id, piece: { file: 3, rank: 3}}
  end

  describe "pieces#show" do
    it "successfully loads the view if a piece exists" do
      get :show, params: { id: @piece.id }
      expect(response).to have_http_status(:success)
    end
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

    end
    it "redirects to the games#show on successful update" do
      sign_in @piece.user
      update_xy
      expect(response).to redirect_to game_path(@piece.game)
    end
    it "does not update the database when not valid" do
      sign_in @piece.user
      patch :update, params: { id: @piece.id, piece: { file: 'huh', rank: 'nope'}}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

end