class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  def index
    @inprogress_games = Game.inprogress
    @pending_games = Game.available
  end

  def challenge
  end

  def team
  end

  def contact
  end

end
