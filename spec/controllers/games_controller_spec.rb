require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe "games#show action" do
    it "should successfully show the game if the game is found" do
      game = FactoryGirl.create(:game)
      get :show, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the game is not found" do
      get :show, params: { id: 'notreal' }
      expect(response).to have_http_status(:not_found)
    end
  end

end
