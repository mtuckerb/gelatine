require 'spec_helper'

describe CheckInsController do
  login_admin 
   let(:user){ FactoryGirl.create(:user, role: "admin")}
   let(:ability){ Ability.new(user)}
  before (:each) do
    controller.stub(:authenticate_user!).and_return true
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  # This should return the minimal set of attributes required to create a valid
  # CheckIn. As you add validations to CheckIn, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "room_id" => "1", "check_in_time" => DateTime.now, "user_id" => user.id }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CheckInsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all check_ins as @check_ins" do
      check_in = CheckIn.create! valid_attributes
      get :index, {}
      assigns(:check_ins).should eq([check_in])
    end
  end

  describe "GET show" do
    it "assigns the requested check_in as @check_in" do
      check_in = CheckIn.create! valid_attributes
      get :show, {:id => check_in.to_param}
      assigns(:check_in).should eq(check_in)
    end
  end

  describe "GET new" do
    it "assigns a new check_in as @check_in" do
      get :new, {}
      assigns(:check_in).should be_a_new(CheckIn)
    end
  end

  describe "GET edit" do
    it "assigns the requested check_in as @check_in" do
      session[:user_id] = user.id
      check_in = CheckIn.create! valid_attributes
      get :edit, {:id => check_in.to_param} 
      assigns(:check_in).should eq(check_in)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CheckIn" do
        expect {
          post :create, {:check_in => valid_attributes}
        }.to change(CheckIn, :count).by(1)
      end

      it "assigns a newly created check_in as @check_in" do
        post :create, {:check_in => valid_attributes} 
        assigns(:check_in).should be_a(CheckIn)
        assigns(:check_in).should be_persisted
      end

      it "redirects to the created check_in" do
        post :create, {:check_in => valid_attributes}
        response.should redirect_to(CheckIn.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved check_in as @check_in" do
        # Trigger the behavior that occurs when invalid params are submitted
        CheckIn.any_instance.stub(:save).and_return(false)
        post :create, {:check_in => { "room_id" => "invalid value" }}
        assigns(:check_in).should be_a_new(CheckIn)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CheckIn.any_instance.stub(:save).and_return(false)
        post :create, {:check_in => { "room_id" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested check_in" do
        check_in = CheckIn.create! valid_attributes
        # Assuming there are no other check_ins in the database, this
        # specifies that the CheckIn created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        CheckIn.any_instance.should_receive(:update_attributes).with({ "room_id" => "1" })
        put :update, {:id => check_in.to_param, :check_in => { "room_id" => "1" }}
      end

      it "assigns the requested check_in as @check_in" do
        check_in = CheckIn.create! valid_attributes
        put :update, {:id => check_in.to_param, :check_in => valid_attributes}
        assigns(:check_in).should eq(check_in)
      end

      it "redirects to the check_in" do
        check_in = CheckIn.create! valid_attributes
        put :update, {:id => check_in.to_param, :check_in => valid_attributes}
        response.should redirect_to(check_in)
      end
    end

    describe "with invalid params" do
      it "assigns the check_in as @check_in" do
        check_in = CheckIn.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CheckIn.any_instance.stub(:save).and_return(false)
        put :update, {:id => check_in.to_param, :check_in => { "room_id" => "invalid value" }}
        assigns(:check_in).should eq(check_in)
      end

      it "re-renders the 'edit' template" do
        check_in = CheckIn.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CheckIn.any_instance.stub(:save).and_return(false)
        put :update, {:id => check_in.to_param, :check_in => { "room_id" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested check_in" do
      check_in = CheckIn.create! valid_attributes
      expect {
        delete :destroy, {:id => check_in.to_param}
      }.to change(CheckIn, :count).by(-1)
    end

    it "redirects to the check_ins list" do
      check_in = CheckIn.create! valid_attributes
      delete :destroy, {:id => check_in.to_param}
      response.should redirect_to(check_ins_url)
    end
  end

end
