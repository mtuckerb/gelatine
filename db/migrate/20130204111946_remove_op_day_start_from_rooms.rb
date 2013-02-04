class RemoveOpDayStartFromRooms < ActiveRecord::Migration
  def up
    remove_column :rooms, :opdaystart
    remove_column :rooms, :opdaystop
    add_column :rooms, :operating_days, :string
  end

  def down
    add_column :rooms, :opdaystop, :string
    add_column :rooms, :opdaystart, :string
  end
end
