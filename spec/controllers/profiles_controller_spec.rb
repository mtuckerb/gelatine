require 'spec_helper'


describe ProfilesController do
  login_admin 
  
  let(:user){ FactoryGirl.create(:user, role: "admin")}
  let(:ability){ Ability.new(user)}
  let(:current_user) {FactoryGirl.create(:user, role: "admin")}
  
  before (:each) do
    controller.stub(:authenticate_user!).and_return true
    @request.env["devise.mapping"] = Devise.mappings[:user]
    Profile.destroy_all
  end

  # This should return the minimal set of attributes required to create a valid
  # Profile. As you add validations to Profile, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "about_me" => "MyString", "user_id" => 1}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProfilesController. Be sure to keep this updated too.
describe "GET index" do
    it "assigns all profiles as @profiles" do
      profile = Profile.create! valid_attributes
      get :index, {}
      assigns(:profiles).should eq  ([profile])
    end
  end

  describe "GET show" do
    it "assigns the requested profile as @profile" do
      profile = Profile.create! valid_attributes
      get :show, {:id => profile.to_param}
      assigns(:profile).should eq()
    end
  end

  describe "GET new" do
    it "assigns a new profile as @profile" do
      get :new, {}
      assigns(:profile).should be_a_new(Profile)
    end
  end

  describe "GET edit" do
    it "assigns the requested profile as @profile" do
      profile = Profile.create! valid_attributes
      get :edit, {:id => profile.to_param}
      assigns(:profile).should eq(profile)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Profile" do
        expect {
          post :create, {:profile => valid_attributes}
        }.to change(Profile, :count).by(1)
      end

      it "assigns a newly created profile as @profile" do
        post :create, {:profile => valid_attributes}
        assigns(:profile).should be_a(Profile)
        assigns(:profile).should be_persisted
      end

      it "redirects to the created profile" do
        post :create, {:profile => valid_attributes}
        response.should redirect_to(Profile.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved profile as @profile" do
        # Trigger the behavior that occurs when invalid params are submitted
        Profile.any_instance.stub(:save).and_return(false)
        post :create, {:profile => { "about_me" => "invalid value" }}
        assigns(:profile).should be_a_new(Profile)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Profile.any_instance.stub(:save).and_return(false)
        post :create, {:profile => { "about_me" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested profile" do
        profile = Profile.create! valid_attributes
        # Assuming there are no other profiles in the database, this
        # specifies that the Profile created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Profile.any_instance.should_receive(:update_attributes).with({ "about_me" => "MyString" })
        put :update, {:id => profile.to_param, :profile => { "about_me" => "MyString" }}
      end

      it "assigns the requested profile as @profile" do
        profile = Profile.create! valid_attributes
        put :update, {:id => profile.to_param, :profile => valid_attributes}
        assigns(:profile).should eq(profile)
      end

      it "redirects to the profile" do
        profile = Profile.create! valid_attributes
        put :update, {:id => profile.to_param, :profile => valid_attributes}
        response.should redirect_to(profile)
      end
    end

    describe "with invalid params" do
      it "assigns the profile as @profile" do
        profile = Profile.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Profile.any_instance.stub(:save).and_return(false)
        put :update, {:id => profile.to_param, :profile => { "about_me" => "invalid value" }}
        assigns(:profile).should eq(profile)
      end

      it "re-renders the 'edit' template" do
        profile = Profile.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Profile.any_instance.stub(:save).and_return(false)
        put :update, {:id => profile.to_param, :profile => { "about_me" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested profile" do
      profile = Profile.create! valid_attributes
      expect {
        delete :destroy, {:id => profile.to_param}
      }.to change(Profile, :count).by(-1)
    end

    it "redirects to the profiles list" do
      profile = Profile.create! valid_attributes
      delete :destroy, {:id => profile.to_param}
      response.should redirect_to(profiles_url)
    end
  end

end
