class ReservationMailer < ActionMailer::Base
  default :from => 'noreply@tuckerbradford.com'
  
  def confirmation(reservation)
    @reservation = reservation
    @url = "http://#{PUBLIC_URL}/reservation/#{reservation.id})"
    attachments['meeting.ics'] =   {:mime_type => 'text/calendar', :content => reservation.to_ics.export }
    mail(:to => reservation.user.email, 
    :subject => "Confirmation # #{@reservation.id} for #{@reservation.room.name}") do |format|
      format.html
      format.text 
    end
  end
  
end