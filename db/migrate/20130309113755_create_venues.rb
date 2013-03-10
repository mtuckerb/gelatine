class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :open_from
      t.string :open_to
      t.string :open_days

      t.timestamps
    end
  end
end
