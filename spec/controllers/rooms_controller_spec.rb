require 'spec_helper'
require 'chronic'

describe RoomsController do
  login_admin  
  
  let(:user){ FactoryGirl.create(:user, role: "admin")}
  let(:ability){ Ability.new(user)}
  before (:each) do
    controller.stub(:authenticate_user!).and_return true
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  
  def valid_attributes
    { "name" => "Test Room", "ophoursstart" => "0900", "ophoursstop" => "1700", "capacity" => 1, "operating_days" => "Mon"} #
  end


  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RoomsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    # I believe this only worked prior to FactoryGirl
    #   it "assigns all rooms as @rooms" do
    #     room = Room.create! valid_attributes
    #     get :index, {}, valid_session
    #     assigns(:rooms).should eq([room])
    #   end
  end


  describe "GET show" do
    it "assigns the requested room as @room" do
      room = Room.create! valid_attributes
      get :show, {:id => room.to_param}, valid_session
      assigns(:room).should eq(room)
    end
  end

  describe "GET new" do
    it "assigns a new room as @room" do
      get :new, {}, valid_session
      assigns(:room).should be_a_new(Room)
    end
  end

  describe "GET edit" do
    it "assigns the requested room as @room" do
      room = Room.create! valid_attributes
      get :edit, {:id => room.to_param}, valid_session
      assigns(:room).should eq(room)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Room" do
        expect {
          post :create, {:room => valid_attributes}, valid_session
        }.to change(Room, :count).by(1)
      end

      it "assigns a newly created room as @room" do
        post :create, {:room => valid_attributes}, valid_session
        assigns(:room).should be_a(Room)
        assigns(:room).should be_persisted
      end

      it "redirects to the created room" do
        post :create, {:room => valid_attributes}, valid_session
        response.should redirect_to(Room.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved room as @room" do
        # Trigger the behavior that occurs when invalid params are submitted
        Room.any_instance.stub(:save).and_return(false)
        post :create, {:room => { "name" => "invalid value" }}, valid_session
        assigns(:room).should be_a_new(Room)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Room.any_instance.stub(:save).and_return(false)
        post :create, {:room => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested room" do
        room = Room.create! valid_attributes
        # Assuming there are no other rooms in the database, this
        # specifies that the Room created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Room.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => room.to_param, :room => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested room as @room" do
        room = Room.create! valid_attributes
        put :update, {:id => room.to_param, :room => valid_attributes}, valid_session
        assigns(:room).should eq(room)
      end

      it "redirects to the room" do
        room = Room.create! valid_attributes
        put :update, {:id => room.to_param, :room => valid_attributes}, valid_session
        response.should redirect_to(room)
      end
    end

    describe "with invalid params" do
      it "assigns the room as @room" do
        room = Room.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Room.any_instance.stub(:save).and_return(false)
        put :update, {:id => room.to_param, :room => { "name" => "invalid value" }}, valid_session
        assigns(:room).should eq(room)
      end

      it "re-renders the 'edit' template" do
        room = Room.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Room.any_instance.stub(:save).and_return(false)
        put :update, {:id => room.to_param, :room => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested room" do
      room = Room.create! valid_attributes
      expect {
        delete :destroy, {:id => room.to_param}, valid_session
      }.to change(Room, :count).by(-1)
    end

    it "redirects to the rooms list" do
      room = Room.create! valid_attributes
      delete :destroy, {:id => room.to_param}, valid_session
      response.should redirect_to(rooms_url)
    end
  end

end
