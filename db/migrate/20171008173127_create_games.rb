class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :white_player_id
      t.integer :black_player_id
      t.integer :winning_player_id
      t.string :game_state
      
      t.timestamps
    end
  end
end
