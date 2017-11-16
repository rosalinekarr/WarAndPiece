class PiecesController < ApplicationController
before_action :authenticate_user!, only: :update

  def show
    render plain: 'Forbidden', status: :forbidden if current_piece.user != current_user
    render plain: 'Not Found :(', status: :not_found if current_piece.blank?
    @piece_coord = [current_piece.file] + [current_piece.rank]
  end

  def update
    return render_not_found if current_piece.blank?
    if current_piece.user != current_user
      return render plain: 'Forbidden :(', status: :forbidden
    end

    current_piece.move_to!(params[:piece][:file], params[:piece][:rank])

    if current_piece.valid?
      Move.create(
        piece_id: current_piece.id, 
        game_id: current_piece.game_id, 
        rank: current_piece.rank, 
        file: current_piece.file
        )
      redirect_to game_path(current_piece.game.id)
    else
      return render plain: 'Not Valid', status: :unprocessable_entity
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:rank, :file)
  end

  helper_method :current_piece
  def current_piece
    @current_piece ||= Piece.find_by_id(params[:id])
  end

end
