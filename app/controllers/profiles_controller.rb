class ProfilesController < ApplicationController
  # GET /profiles
  # GET /profiles.json
  load_and_authorize_resource
  autocomplete :skills, :name, :class_name => 'ActsAsTaggableOn::Tag'
  autocomplete :needs, :name, :class_name => 'ActsAsTaggableOn::Tag'
  autocomplete :interests, :name, :class_name => 'ActsAsTaggableOn::Tag'
  
  def tagged
      if params[:skill].present? 
        @profiles = Profile.tagged_with(params[:skill], :on => :skills)
      elsif params[:interests].present?
        @profiles = Profile.tagged_with(params[:interests], :on => :interests)
      elsif params = params[:need].present? 
        @profile = Profile.tagged_with(params[:need], :on => :needs)
      end
      respond_to do |format|
          format.html {render :index}
      end  
  end
  
  def index
    @profiles = Profile.all(:include => :user)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render_for_api :profiles_with_user, json: @profiles, :root => :profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
    @checkin = CheckIn.find_last_by_user_id(@profile.user_id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    current_user.admin? ? @profile = Profile.find(params[:id], :include => :user) : @profile = Profile.find_by_user_id(current_user, :include => :user)
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        current_user.admin? ? true : params[:profile][:id] = current_user.id
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end
end
