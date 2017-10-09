class CreateMoves < ActiveRecord::Migration[5.1]
  def change
    create_table :moves do |t|
      t.integer :game_id
      t.integer :piece_id
      t.integer :rank
      t.integer :file
      t.timestamps
    end
  end
end
