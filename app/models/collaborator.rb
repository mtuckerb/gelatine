class Collaborator < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
  attr_accessible :order, :project_id, :user_id
end
