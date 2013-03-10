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

  def active?(ctrlr, action)
  	"class=active" if params[:controller] == ctrlr.to_s && params[:action] == action.to_s
  end
end
