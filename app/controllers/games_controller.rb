class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :update, :join]

  def index
    @games = Game.all
    @pending_games = Game.available
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.white_player.id = current_user.id
    @game.save
    redirect_to root_path
  end

  def show
    @game = Game.find(params[:id])
  end

  def join
    @game = Game.find(params[:game_id])
    @game.update_attributes(black_player_id: current_user.id)
    redirect_to game_path(@game)
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
    params.require(:game).permit(:white_player_id, :black_player_id, :game_state)
  end
end
