require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#index action" do
    it "should require player to be logged in" do
      get :new 
      expect(response).to redirect_to new_user_session_path
    end
    it "should successfully show game" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "games#new action" do
    it "should require player to be logged in" do
      get :new 
      expect(response).to redirect_to new_user_session_path
    end
    it "should successfully show form for new game" do
    #a popup/modal asking if the player would like to start a new game
      player = FactoryGirl.create(:user)
      sign_in player
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "games#create action" do
    it "should successfully create a new game in our database" do
      player = FactoryGirl.create(:user)
      sign_in player
      post :create, params: { game: { game_state: "new game" } }
      expect(response).to redirect_to root_path
      
      game = Game.last
      expect game.game_state.to eq("new game")
      expect game.user.to eq(player)
    end
  end
end
