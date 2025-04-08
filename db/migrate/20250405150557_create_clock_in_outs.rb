class CreateClockInOuts < ActiveRecord::Migration[7.0]
  def change
    create_table :clock_in_outs do |t|
      t.datetime :clock_in
      t.datetime :clock_out
      t.integer :duration
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end

  add_index(:clock_in_outs, :user_id)
  add_index(:clock_in_outs, [:user_id, :clock_in])
end
