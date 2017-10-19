class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :update, :join]
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

  def join
    @game = Game.find(params[:id])
    @game.update_attributes(@game.black_player_id = current_user.id)
    redirect_to join_games_path
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    redirect_to root_path
  end

  def destroy
    @game = Game.find(params[:id])
      return not_found(:forbidden) if @game.user != current_user
    @game.destroy
    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(@game.white_player_id = current_user.id)
  end
end
