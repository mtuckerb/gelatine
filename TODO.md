TODO: 

=Projects:
* What are we interested in here (tracking, collaborating, public outreach, propping users?)

=Booking
* make model/reservation_spec "already booked" test more robust (don't just duplicate the whole record"
* write custom validation for room_availability. Check Room.is_available
* background confirmation emails
* restrict json results in Reservation/index and Calendar/index

=Profile
* Make sure the recent changes to Profile were made universally (registrations/new,edit)
* write more unit tests
* add gravatar support for avis
* fix dragonfly storage location so it survives capistrano 
* check parser (seems to be bringing wrong username)