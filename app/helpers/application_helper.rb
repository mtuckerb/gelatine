module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  
  def active?(ctrlr, action)
  	"class=active" if params[:controller] == ctrlr.to_s && params[:action] == action.to_s
  end
end
