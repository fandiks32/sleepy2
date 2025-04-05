class CreateClockInOuts < ActiveRecord::Migration[7.0]
  def change
    create_table :clock_in_outs do |t|
      t.date :target_date
      t.datetime :clock_in
      t.datetime :clock_out
      t.integer :duration
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
