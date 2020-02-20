require 'rails_helper'

RSpec.feature "HomePage", type: :feature do 
  scenario "Login success" do 
    login
    expect(page).to have_content("Logged in as BigJD")
  end
end
