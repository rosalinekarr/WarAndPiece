class PiecesController < ApplicationController
before_action :authenticate_user!, only: :update

  def update
    # puts params.inspect
    return render_not_found if current_piece.blank?
    if current_piece.user != current_user
      return render plain: 'Forbidden :(', status: :forbidden
    end
    current_piece.update_attributes(piece_params)
    # if (piece_params.include?(:rank) && piece_params.include?(:file))
    #   move = Move.create({
    #     piece_id: current_piece.id,
    #     game_id: current_piece.game_id,
    #     rank: rank,
    #     file: file
    #   }).save!
    # end
    if current_piece.valid?
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
    # puts params
    params.require(:piece).permit(:rank, :file)
  end

end
