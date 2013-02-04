class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :ophoursstart
      t.string :ophoursstop
      t.string :opdaystart
      t.string :opdaystop
      t.integer :capacity
      t.string :notes

      t.timestamps
    end
  end
end
