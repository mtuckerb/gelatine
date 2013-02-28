class Profile < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  acts_as_api

  alias_attribute :category, :interests
  alias_attribute :help, :needs
  
  api_accessible :profiles_with_user do |t| 
    t.add :user
  end

  api_accessible :distinct_user_checkins do |t| 
    t.add :skills
    t.add :interests
    t.add :needs
    t.add :about_me
    t.add :goodreads
    t.add :mood
    t.add :public_email
    t.add :twitter
    t.add :website
  end

  acts_as_taggable_on :skills, :interests, :needs
  attr_accessible :user_id, :about_me, :goodreads, :mood, :public_email, :send_via_email
  attr_accessible :terms_and_conditions, :twitter, :website, :need_list, :skill_list, 
  	:interest_list, :avatar_image, :remove_avatar_image, :retained_avatar_image
  validates :terms_and_conditions, :acceptance => true, :on => :create
  image_accessor :avatar_image 
  private
  
end
