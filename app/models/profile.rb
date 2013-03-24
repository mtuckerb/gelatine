class Profile < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  acts_as_api
  paginates_per 5

  alias_attribute :category, :interests
  alias_attribute :help, :needs
  
  api_accessible :profiles_with_user do |t| 
    t.add :user
  end



  acts_as_taggable_on :skills, :interests, :needs
  attr_accessible :user_id, :about_me, :goodreads, :mood, :public_email, :send_via_email
  attr_accessible :terms_and_conditions, :twitter, :website, :need_list, :skill_list, 
  	:interest_list, :avatar_image, :remove_avatar_image, :retained_avatar_image, :github_url
  validates :terms_and_conditions, :acceptance => true, :on => :create
  image_accessor :avatar_image 


  def skills_string
    return self.skill_list.to_s
  end

  private
  
end
