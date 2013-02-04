class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :room_id
      t.datetime :start_time
      t.datetime :stop_time
      t.integer :attendie_count

      t.timestamps
    end
  end
end
