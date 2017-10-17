class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :update]
  def index
    @games = Game.all
  end
  
  def new
    @game = Game.new
  end
  
  def create
    @game = Game.create(game_params)
    redirect_to root_path
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    redirect_to_root_path
  end

  private

  def game_params
    params.require(:game).permit(@game.white_player_id = current_user.id)
  end
end
