require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
  end

  scenario "They can login and will be redirected to the home page afterwards." do
    User.create!(first_name: "Q", last_name: "J", email: "test@test.com", password:"123456789")
    visit login_path

    within "form" do
      fill_in id: "user_email", with: "test@test.com"
      fill_in id: "user_password", with: "123456789"
      click_button "Login"
    end
    expect(page).to have_content("Products")
  end

end
