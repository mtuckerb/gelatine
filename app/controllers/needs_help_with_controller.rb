class NeedsHelpWithController < ApplicationController
  def index
    @tags = Profile.tag_counts_on(:needs)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end
end
