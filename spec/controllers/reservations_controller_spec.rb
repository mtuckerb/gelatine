require 'spec_helper'
require 'chronic'

describe ReservationsController do

  login_admin 
  
   let(:user){ FactoryGirl.create(:user, role: "admin")}
   let(:ability){ Ability.new(user)}
   let(:current_user) {FactoryGirl.create(:user, role: "admin")}
  before (:each) do
    controller.stub(:authenticate_user!).and_return true
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  def valid_attributes
    { "user" => user, "start_time" => Chronic.parse("Thursday at 2pm"), "stop_time" => Chronic.parse("Thursday at 3pm"), "room_id" => 1 }
  end

  describe "GET index" do
    before(:each) do
      get 'index'
    end

    it "returns http success" do
      response.should be_success
    end

    it "should render the index template" do
      response.should render_template(:index)
    end

    it "will only show reservations for current_user" do
      get :index,  {} 
      assigns(:reservations).each do |res|
        expect(res.user).to eq current_user
      end
    end

  end

  describe "GET show" do
    it "assigns the requested reservation as @reservation" do
      reservation = FactoryGirl.create(:reservation, user: user)
      get :show, {:id => reservation.to_param}
      assigns(:reservation).should eq(reservation)
    end
  end

  describe "GET new" do
    it "assigns a new reservation as @reservation" do
      get :new, {}
      assigns(:reservation).should be_a_new(Reservation)
    end
    
    it "assigns all rooms to @rooms" do
      reservation = FactoryGirl.create(:reservation, user: user)
      get :edit, {:id => reservation.to_param}
      expect(assigns(:rooms)).not_to be_nil
    end
  end

  describe "GET edit" do
    let(:reservation) { FactoryGirl.create(:reservation, user: user)}

    it "assigns the requested reservation as @reservation" do
      get :edit, {:id => reservation.to_param}
      expect(assigns(:reservation)).to eq(reservation)
    end

    it "assigns all rooms to @rooms" do
      get :edit, {:id => reservation.to_param}
      expect(assigns(:rooms)).not_to be_nil
    end
  end

  describe "POST create" do
    let(:reservation) { mock_model(Reservation, valid_attributes ).as_null_object}
    before  do
      Reservation.stub(:new).and_return(reservation)
    end

    describe "with valid params" do
      it "creates a new Reservation" do
        Reservation.should_receive(:new).and_return(reservation)
        post :create, reservation: :reservation

      end

      it "saves the reservation" do
        reservation.should_received(:save)
        post :create
      end

      it "assigns a newly created reservation as @reservation" do
        post :create, reservation: FactoryGirl.build(:reservation, created_at: nil, updated_at: nil)
        assigns(:reservation).should be_a(Reservation)
        assigns(:reservation).should be_persisted
      end

      it "redirects to the created reservation" do
        post :create
        response.should redirect_to reservation_path(reservation)
      end

      it "creates reservation with end time one hour after start" do
        expect {
          post :create, reservation:  FactoryGirl.build(:reservation , created_at: nil, updated_at: nil)
        }.not_to raise_error()
      end

    end
    context "when reservation saves successfully" do
      before(:each) do
        reservation.stub!(:save).and_return(true)
      end

      it "sets a flash notice" do
        post :create
        flash[:notice].should be
      end

      it "redirects to the new reservations's page" do
        post :create
        response.should redirect_to reservation_path(reservation)
      end
    end
    context "when the reservation fails to save" do
      before(:each) do
        reservation.stub!(:save).and_return(false)
      end

      it "assigns @reservation" do
        post :create
        assigns(:reservation).should eql(reservation)
      end
      it "renders new template" do
        post :create
        response.should render_template(:new)
      end

    end

  end


  describe "PUT update" do
    let(:reservation) { mock_model(Reservation).as_null_object }

    before do
      Reservation.stub(:find).and_return(reservation)
    end

    it "updates the reservation" do
      reservation.should_receive(:update_attributes)
      put :update, id: reservation.id, :reservation => { "attendie_count" => 3}
    end
    
    it "assigns @reservation" do
      put :update, id: reservation.id
      assigns(:reservation).should eq(reservation)
    
    end

    context "when the reservation updates successfully" do
      before :each do
        reservation.stub!(:update_attributes).and_return(true)
        put "update", id: reservation.id
      end

      it "redirects to the reservation page" do
        response.should redirect_to reservation_path(reservation)
      end

      it "sets a flash notice" do
        flash[:notice].should be
      end

    end
    context "when the reservation fails to update" do
      before(:each) do
        reservation.stub!(:update_attributes).and_return(false)
        put :update, id: reservation.id
      end

      it "renders edit template" do
        response.should render_template(:edit)
      end
      
      # it "sets a flash warning" do
      #       flash[:error].should be
      #     end
      
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested reservation" do
      reservation = FactoryGirl.create(:reservation)
      expect {
        delete :destroy, {:id => reservation.to_param}
      }.to change(Reservation, :count).by(-1)
    end

    it "redirects to the reservations list" do
      reservation = FactoryGirl.create(:reservation)
      delete :destroy, {:id => reservation.to_param}
      response.should redirect_to(reservations_url)
    end
  end

end
