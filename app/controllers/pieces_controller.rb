class PiecesController < ApplicationController
before_action :authenticate_user!, only: :update

  def update
    return render_not_found if current_piece.blank?
    if current_piece.user != current_user
      return render plain: 'Forbidden :(', status: :forbidden
    end

    if current_piece.move_to!(params[:piece][:file].to_i, params[:piece][:rank].to_i)
      Move.create(
        piece_id: current_piece.id, 
        game_id: current_piece.game_id, 
        rank: current_piece.rank, 
        file: current_piece.file
        )
    # else
    #   return render plain: 'Not Valid', status: :unprocessable_entity
    end
    
    # redirect_to game_path(current_piece.game.id)
  end

  private

  helper_method :current_piece
  def current_piece
    @current_piece ||= Piece.find_by_id(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:rank, :file)
  end

end
