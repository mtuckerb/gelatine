# coding: utf-8
require 'spec_helper'
require "cancan/matchers"

describe "User" do
  describe "abilities" do
    subject { ability }
    let(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "is an admin" do
      let(:user){ FactoryGirl.create(:admin) }
      it "can create/update/view a Reservation" do
        should be_able_to(:manage, Reservation.new)
      end
      it "can create/update/view a User" do
        should be_able_to(:manage, User.new)
      end

    end

    context "is not an admin" do
      let(:user){ FactoryGirl.create(:user, role: nil) }
      let(:reservation) { FactoryGirl.create(:reservation, user: user)}
      it "doesn't allow user to manage Reservation" do
        should_not be_able_to(:manage, Reservation.new)
      end
      it "doesn't allow user to manage Room" do
        should_not be_able_to(:manage, Room.new)
      end
      it "doesn't allow user to manage User" do
        should_not be_able_to(:manage, User.new)
      end
      it "create/update Reservation" do
        should be_able_to(:create, Reservation.new)
        should be_able_to(:update, reservation)
      end
      it "can not change its own role" do
        should_not be_able_to(:access, User, [:role])
      end
    end
  end
end
