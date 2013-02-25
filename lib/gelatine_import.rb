require 'json'
require 'open-uri'

gelatine =  JSON.parse( open("http://theedge.checkinsystem.net/API/view_list_distinctusercheckins_all.php" ).read)
gelatine.each do |json_user| 
  next if  User.exists?(:email => json_user["email"]
  next unless json_user["email"].match(/@/)
  user = User.new(
    :name => "#{json_user['firstname']} #{json_user['lastname']}",
    :email => json_user["email"],
    :password => Devise.friendly_token[0,20],
  :confirmed_at => DateTime.now )
  user.skip_confirmation!
  user.save!
  user.reload
  user.profile.interest_list = json_user['categories'].join(",")
  user.profile.skill_list = json_user['skills'].join(",")
  user.profile.need_list = json_user['help'].join(",")
  user.profile.about_me = json_user['aboutme']
  user.profile.mood = json_user['status']
  user.profile.goodreads = json_user["goodreadsurl"]
  user.profile.twitter =json_user["twitter"]
  user.profile.website = json_user["blog"]
  user.profile.public_email = json_user["email"]
  user.profile.avatar_image_url = json_user["avatarurl"]
  user.save!
end
