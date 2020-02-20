require 'web_helpers'
require 'rails_helper'

feature "A user can add another user as a friend" do 
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:post) { create(:post, user_id: user1.id) }

  scenario "User clicks add friend and they can see them on friends" do 
    user1
    user2
    post 
    sign_up
    click_link("See All Posts")
    click_link(user1.username)
    click_link("Add friend")
    expect(page).to have_content("Added friend.")
  end 
end
