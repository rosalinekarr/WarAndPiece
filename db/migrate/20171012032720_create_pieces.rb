class CreatePieces < ActiveRecord::Migration[5.1]
  def change
    create_table :pieces do |t|
      t.string :type
      t.integer :game_id
      t.integer :white_player_id
      t.integer :black_player_id
      t.integer :rank
      t.string :file
      t.integer :move_id
      t.boolean :is_captured, default: false

      t.timestamps
    end
  end
end
