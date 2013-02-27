Gelatine
===========

The goal of this project is to link physical resources, mentor-people, and people-with-mentoring-needs, so that they can find each other, set up a place to meet and collaborate, and release the resources when they are done.book_a_room


- Installation (on a Mac):

Install rails ([try this ](http://www.frederico-araujo.com/2011/07/30/installing-rails-on-os-x-lion-with-homebrew-rvm-and-mysql/)

clone this repository 
```
git clone https://github.com/mtuckerb/gelatine.git
```
hop into the repository's root 

```
$ bundle install
$ rake db migrate
$ rails server &
```
to create your initial (admin) user do
```
$ rails console
user = User.create(:username => "Your Name", :password => "Your password", :email => "your@email")
user.reload
user.role = :admin
user.save!
```
You should now get an email, click the link to confirm your user and it's off to the races!

open your browser and go to http://localhost:3000


- Deploy to server (incomplete)
* edit config/deploy.rb, set your server and login information
* cap deploy
 on remote server
```
$ RAILS_ENV=production bundle exec rake assets:precompile
$ RAILS_ENV=production rake db:setup 
```
* restart your webserver
* create an initial user
```
$ RAILS_ENV=production rails console

user = User.last() (or appropriate)
user.role = :admin
user.save!
```