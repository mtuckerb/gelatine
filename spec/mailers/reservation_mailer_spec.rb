require 'spec_helper'

describe ReservationMailer do
  describe 'confirmation' do
    let (:reservation) { FactoryGirl.create(:reservation)}
    let (:mail) { ReservationMailer.confirmation(reservation)}
    
    it "renders the subject" do
      mail.subject.should match("Confirmation")
      
    end
    
    it "renders the receiver email" do
      mail.to.should == [reservation.user.email]
    end
    
    it "renders the sender email" do
      mail.from.should == ["noreply@tuckerbradford.com"]
    end
    
    it "assigns @name" do
      mail.body.encoded.should match(reservation.user.name)
    end
    
    it "assigns ics file" do
      mail.body.encoded.should match("meeting.ics")
      
    end
  end
end