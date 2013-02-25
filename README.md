=Gelatine
===========

The goal of this project is to link physical resources, mentor-people, and people-with-mentoring-needs, so that they can find each other, set up a place to meet and collaborate, and release the resources when they are done.book_a_room


- Installation:

* edit config/deploy.rb, set your server and login information
* cap deploy
 on remote server
* RAILS_ENV=production bundle exec rake assets:precompile
* RAILS_ENV=production rake db:setup 

* restart your webserver
* create an initial user
* RAILS_ENV=production rails console
* user = User.last() (or appropriate)
* user.role = :admin
* user.save!
