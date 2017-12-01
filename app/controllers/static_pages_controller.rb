class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:lobby]

  def index
  end

  def lobby
    @inprogress_games = Game.inprogress
    @pending_games = Game.available
  end

  def team
  end

  def contact
  end

  def privacy
  end

end
