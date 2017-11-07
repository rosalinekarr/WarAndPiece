# require 'rails_helper'

# RSpec.describe StaticPagesController, type: :controller do
#   describe "static_pages#index action" do
#     it "should require player to be logged in" do
#       get :new 
#       expect(response).to redirect_to new_user_session_path
#     end
#     it "should successfully show all current games" do
#       player = FactoryGirl.create(:user)
#       sign_in player
#       get :index
#       expect(response).to have_http_status(:success)
#     end
#   end
# end
