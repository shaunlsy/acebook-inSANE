require 'rails_helper'

RSpec.feature "HomePage", type: :feature do 
  scenario "A user signs up successfully" do 
    sign_up
    expect(page).to have_content("You've successfully signed up!")
  end
end
