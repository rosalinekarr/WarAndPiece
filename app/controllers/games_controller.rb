class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    redirect_to_root_path
  end
  
  def destroy
  end
    @game = Game.find(params[:id])
      return not_found(:forbidden) if @game.user != current_user
    @game.destroy
    redirect_to_root_path
  private

  def game_params
    params.require(:game).permit(@game.white_player_id = current_user.id)
  end
end
