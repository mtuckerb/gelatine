class AddRfidToUser < ActiveRecord::Migration
  def change
    add_column :users, :rfid, :string
  end
end
