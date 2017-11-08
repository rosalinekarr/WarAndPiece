class AddRankFileColorToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :rank, :integer
    add_column :games, :file, :integer
    add_column :games, :color, :string
  end
end
