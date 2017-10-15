class AddForeignKeyToGames < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :games, :users, column: :black_player_id, primary_key: :id
    add_foreign_key :games, :users, column: :white_player_id, primary_key: :id
  end
end
