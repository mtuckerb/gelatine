require 'spec_helper'

describe "CheckIns" do
  describe "GET /check_ins" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get check_ins_path
      response.status.should eq(302)
    end
  end
end
