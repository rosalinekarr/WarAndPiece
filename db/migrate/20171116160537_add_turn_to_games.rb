class AddTurnToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :turn, :boolean, default: true
  end
end
