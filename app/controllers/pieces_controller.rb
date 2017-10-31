class PiecesController < ApplicationController
before_action :authenticate_user!, only: :update

  def show
    if current_piece.blank?
      render plain: 'Not Found :(', status: :not_found
    end
    @piece_coord = [current_piece.file] + [current_piece.rank]
    # puts @piece_coord.inspect
  end

  def update
    # puts params.inspect
    return render_not_found if current_piece.blank?
    if current_piece.user != current_user
      return render plain: 'Forbidden :(', status: :forbidden
    end
    current_piece.update_attributes(piece_params)
    if current_piece.valid?
      redirect_to game_path(current_piece.game.id)
    else
      return render :edit, status: :unprocessable_entity
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
