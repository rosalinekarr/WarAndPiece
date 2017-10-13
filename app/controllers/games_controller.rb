class GamesController < ApplicationController
  before_action :authenticate_user!
  def index
    #will the index show all games or just the current game? - RRS
    @games = Game.all
  end
  
  def new
    @game = Game.new
  end
  
  def create
    @game = Game.create(game_params)
  end
  
  def private
    def game_params 
      params.require(:game).permit(:game_state)
    end
  end
end