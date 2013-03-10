class AddVenueIdToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :venue_id, :integer
  end
end
