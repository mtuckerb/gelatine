class AddGithubToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :github_url, :string
  end
end
