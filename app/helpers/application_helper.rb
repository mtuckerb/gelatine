module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  
  def profile_image(profile = Profile)
  	profile = @profile if @profile
  	if profile.avatar_image
  		return(image_tag profile.avatar_image.thumb("100x100#").url :class => "thumbnail media border-img")
  	else
  		gravatar_image_tag(profile.user.email, :alt => profile.user.name, :gravatar => {:default => :monsterid})
	end
  end

  def class_active?(ctrlr, action)
  	"active" if params[:controller] == ctrlr.to_s && params[:action] == action.to_s
  end
  
  def check_in_check_out
    if current_user
      
        if current_user.check_ins.last.try :is_checked_in
          link_to "Check Out", check_out_path
        else
          link_to "Check In", new_check_in_path
        end
      
    end
   
  end

  def search_block
    if  params[:controller] == "profiles" && params[:action] == "index"
      render "profiles_search"
    end
  end
end
