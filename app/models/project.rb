class Project < ActiveRecord::Base
  has_many :users, :through => :collaborators
  has_many :collaborators

  acts_as_taggable_on :tags
  attr_accessible :category, :description, :title, :user_ids


end
