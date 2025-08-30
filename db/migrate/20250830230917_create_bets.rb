class CreateBets < ActiveRecord::Migration[8.0]
  def change
    create_table :bets do |t|
      t.references :player, null: false, foreign_key: true
      t.references :game_round, null: false, foreign_key: true
      t.decimal :amount
      t.string :bet_color
      t.decimal :payout
      t.boolean :won

      t.timestamps
    end
  end
end
