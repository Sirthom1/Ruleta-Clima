class CreateWeathers < ActiveRecord::Migration[8.0]
  def change
    create_table :weathers do |t|
      t.date :date
      t.boolean :hot_day

      t.timestamps
    end
  end
end
