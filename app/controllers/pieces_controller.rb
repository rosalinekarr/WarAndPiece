class PiecesController < ApplicationController
before_action :authenticate_user!, only: :update

  def show
    @piece = Piece.find_by_id(params[:id])
    if @piece.blank?
      render plain: 'Not Found :(', status: :not_found
    end
  end

  def update
    @piece = Piece.find_by_id(params[:id])
    return render_not_found if @piece.blank?
    if @piece.user != current_user
      return render plain: 'Forbidden :(', status: :forbidden
    end
    @piece.update_attributes(piece_params)
    if @piece.valid?
      redirect_to game_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:file, :rank)
  end

  # helper_method :current_piece
  # def current_piece
  # end

end
