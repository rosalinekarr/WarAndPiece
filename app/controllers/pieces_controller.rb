require "addressable/uri"
require "addressable/template"

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
    return render_not_found if current_piece.blank?
    if current_piece.user != current_user
      return render plain: 'Forbidden :(', status: :forbidden
    end
    current_piece.update_attributes(piece_params) ## HOW are we sucking in the file & rank
                                                  ## from the square id's clicked on?
    if current_piece.valid?
      redirect_to game_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  private

  def piece_params
    uri = Addressable::URI.parse(request.original_url)
    puts uri.inspect
    xy = uri.query_values   ## https://stackoverflow.com/a/945343/8035833
    puts xy.inspect
    file = uri.query_values.first
    rank = uri.query_values.last
    puts file.inspect
    puts rank.inspect
    params.require(:piece).permit({:file => file, :rank => rank})
  end

  helper_method :current_piece
  def current_piece
    @current_piece ||= Piece.find_by_id(params[:id])
  end

end
