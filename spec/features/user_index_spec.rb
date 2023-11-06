require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  scenario 'I can see the username of all other users' do
    visit users_path
    expect(page).to have_selector('.user', count: User.count)
    User.all.each do |user|
      expect(page).to have_link(user.name, href: user_url(user))
    end
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_css("#user_#{user.id} img.profile-picture")
    end
  end

  scenario 'I can see the number of posts each user has written' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_content("Posts: #{user.posts.count}")
    end
  end

  scenario 'When I click on a user, I am redirected to that users show page' do
    visit users_path
    User.all.each do |user|
      find("#user_#{user.id}").click
      expect(current_path).to eq(user_path(user))
      visit users_path
    end
  end
end
