class CreateGameRounds < ActiveRecord::Migration[8.0]
  def change
    create_table :game_rounds do |t|
      t.integer :result_number
      t.string :result_color
      t.datetime :played_at

      t.timestamps
    end
  end
end
