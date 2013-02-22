class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.integer :room_id
      t.datetime :check_in_time
      t.datetime :check_out_time
      t.string :third_party_id
      t.integer :user_id

      t.timestamps
    end
  end
end
