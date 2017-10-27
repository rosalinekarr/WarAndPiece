require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe "pieces#show" do
    it "should successfully load the view if a piece exists" do
      piece = FactoryGirl.create(:piece)
      ## define click action??
      get :show, params: { id: piece.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "pieces#update" do
    it "should update the file and rank of the chess piece when moved" do
      piece = FactoryGirl.create(:piece)
      sign_in piece.user
      patch :update, params: { id: piece.id, piece: { file: 3, rank: 3}}
      piece.reload
      expect(piece.file).to eq 3
      expect(piece.rank).to eq 3
    end
    it "shouldn't let players who don't own a piece update it" do
      piece = FactoryGirl.create(:piece)
      player = FactoryGirl.create(:user)
      sign_in player
      patch :update, params: { id: piece.id, piece: { file: 3, rank: 3}}
      expect(response).to have_http_status(:forbidden)
    end
    it "should create a move model on update" do

    end
    it "should redirect to the games#show once done" do

    end
  end

end
