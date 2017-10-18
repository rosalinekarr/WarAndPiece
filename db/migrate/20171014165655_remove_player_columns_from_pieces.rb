class RemovePlayerColumnsFromPieces < ActiveRecord::Migration[5.1]
  def change
    remove_column :pieces, :black_player_id
    remove_column :pieces, :white_player_id
  end
end
