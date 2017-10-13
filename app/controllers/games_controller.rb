class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    redirect_to_root_path
  end

  private

  def game_params
    params.require(:game).permit(xxxx)
  end
end
