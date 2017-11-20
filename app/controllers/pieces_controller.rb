class PiecesController < ApplicationController
before_action :authenticate_user!, only: :update

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
        @game = current_piece.game
        if @game.check(current_piece)
          flash[:alert] = "Check!"
        end
      redirect_to game_path(current_piece.game.id)
    else
      return render plain: 'Not Valid', status: :unprocessable_entity
    end
  end

  private

  def current_piece
    @current_piece ||= Piece.find_by_id(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:rank, :file)
  end

end
