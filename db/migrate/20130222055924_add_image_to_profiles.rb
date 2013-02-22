class AddImageToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :avatar_image_uid, :string
    add_column :profiles, :avatar_image_name, :string
  end
end
