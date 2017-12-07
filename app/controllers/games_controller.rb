class GamesController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.white_player_id = current_user.id
    @game.save
    if @game.valid?
      redirect_to lobby_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @game = Game.find_by_id(params[:id])
    return render_not_found if @game.blank?

    # Pusher.trigger(channels, event, data)
    Pusher.trigger(@game.id, 'player-moved', {
      message: 'hello world'
    })

    if @game.turn == true && current_user == @game.white_player ||
     @game.turn == false && current_user == @game.black_player
      @turn = "your-turn"
    else
      @turn = "opponent-turn"
    end

  end

  def join
    @game = Game.find(params[:game_id])
    @game.update_attributes(black_player_id: current_user.id, game_state:"inprogress")
    @game.populate_board
    redirect_to game_path(@game)
  end

  def update
    @game = Game.find(params[:id])
    return render_not_found if @game.blank?
    return render_not_found(:forbidden) if @game.user != current_user
    @game.update_attributes(game_params)
    if @game.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end  
  end

  def destroy
    @game = Game.find_by_id(params[:id])
    return render_not_found if @game.blank?
    return render_not_found(:forbidden) if @game.user != current_user    
    @game.destroy
    redirect_to root_path
  end

  private

  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:white_player_id, :black_player_id, :game_state)
  end

end
