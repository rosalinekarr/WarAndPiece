class StaticPagesController < ApplicationController

  def index
    @inprogress_games = Game.inprogress
    @pending_games = Game.available
  end

  def start_game
  end

end
