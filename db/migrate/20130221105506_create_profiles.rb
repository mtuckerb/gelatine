class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :about_me
      t.string :mood
      t.string :twitter
      t.string :goodreads
      t.string :public_email
      t.string :website
      t.boolean :toc_accept
      t.boolean :send_via_email

      t.timestamps
    end
  end
end
