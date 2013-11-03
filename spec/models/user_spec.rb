require 'spec_helper'
# require "shoulda/matchers"

describe User do
  let(:user) {create(:user)}
  it {verifies_uniqueness_of :email}
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "changes password" do
    user.password = "blarf123"
    user.password_confirmation = "blarf123"
    expect(user.save!).to eql(true)
  end


end
