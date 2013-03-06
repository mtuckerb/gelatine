class CheckInsController < ApplicationController
  # GET /check_ins
  # GET /check_ins.json
  load_and_authorize_resource
  def index
    @check_ins = CheckIn.page

    respond_to do |format|
      format.html # index.html.erb
      format.json { render_for_api :distinct_user_checkins, json: @check_ins, :root => :check_ins }
    end
  end

  # GET /check_ins/1
  # GET /check_ins/1.json
  def show
    @check_in = CheckIn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @check_in }
    end
  end

  # GET /check_ins/new
  # GET /check_ins/new.json
  def new
    @check_in = CheckIn.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @check_in }
    end
  end

  # GET /check_ins/1/edit
  def edit
    @check_in = CheckIn.find(params[:id])
  end

  # POST /check_ins
  # POST /check_ins.json
  def create
    @check_in = CheckIn.new(params[:check_in])
    @check_in.user_id = set_user_id(@check_in.user_id)
    @check_in.check_in_time = Time.now unless params[:check_in_time].present? 
    @check_in.check_out_time = nil unless params[:check_out_time].present?
    respond_to do |format|
      if @check_in.save
        format.html { redirect_to @check_in, notice: 'Check in was successfully created.' }
        format.json { render json: @check_in, status: :created, location: @check_in }
      else
        format.html { render action: "new" }
        format.json { render json: @check_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /check_ins/1
  # PUT /check_ins/1.json
  def update
    @check_in = CheckIn.find(params[:id])
    @check_in.user_id = set_user_id(@check_in.user_id)
    respond_to do |format|
      if @check_in.update_attributes(params[:check_in])
        format.html { redirect_to @check_in, notice: 'Check in was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @check_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /check_ins/1
  # DELETE /check_ins/1.json
  def destroy
    @check_in = CheckIn.find(params[:id])
    @check_in.destroy

    respond_to do |format|
      format.html { redirect_to check_ins_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def set_user_id(user_id = params[:user_id])
    if current_user.admin?
      return user_id
    else
      return current_user.id
    end
  end
end
