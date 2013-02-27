describe "the signup process", :type => :feature do
  before :each do
    User.make(:email => 'user@tuckerbradford.com', :password => 'caplin', :name => "Test User")
  end

  it "signs me in" do
    visit '/sessions/new'
    within("#session") do
      fill_in 'Login', :with => 'user@tuckerbradford.com'
      fill_in 'Password', :with => 'password'
      fill_in 'Name', :with => "Test User"
      check 'terms_and_conditions'
    end
    click_link 'Sign in'
    page.should have_content 'Success'
  end
end