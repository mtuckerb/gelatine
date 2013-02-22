class Profile < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  acts_as_taggable_on :skills, :interests, :needs
  attr_accessible :user_id, :about_me, :goodreads, :mood, :public_email, :send_via_email
  attr_accessible :toc_accept, :twitter, :website, :need_list, :skill_list, :interest_list, :avatar_image, :remove_avatar_image, :retained_avatar_image
  validates :toc_accept, :acceptance => true, :on => :create
  image_accessor :avatar_image 
  private
  
end
