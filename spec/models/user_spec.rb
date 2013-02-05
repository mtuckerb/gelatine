require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:room).should be_valid
  end
end
