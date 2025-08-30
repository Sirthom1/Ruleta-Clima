class RemoveResultNumberFromGameRounds < ActiveRecord::Migration[8.0]
  def change
    remove_column :game_rounds, :result_number, :integer
  end
end
