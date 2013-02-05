require 'spec_helper'

describe "Reservations" do

  describe "GET /reservations" do
    reservation = Reservation.new(:user_id => 1, :start_time => "1500", :stop_time => "1700", :attendie_count => 1)
    it "works!" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      #get reservations_path
      #response.status.should be(200)
    end

  end
end
