class ChangeFileToBeIntegerInPieces < ActiveRecord::Migration[5.1]
  def change
    change_column :pieces, :file, 'integer USING CAST(file AS integer)'
  end
end
