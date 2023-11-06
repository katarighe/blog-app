require 'rails_helper'

feature 'User index page' do
  scenario 'I can see the username of all other users' do
    visit users_path
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path
    @users.each do |user|
      expect(page).to have_css("img[src='#{user.avatar_url}']")
    end
  end

  scenario 'I can see the number of posts each user has written' do
    visit users_path

    @users.each do |user|
      expect(page).to have_content("Posts: #{user.posts_count}")
    end
  end

  scenario 'When I click on a user, I am redirected to that users show page' do
    visit users_path
    user = @users.first
    click_link user.name
    expect(page).to have_current_path(user_path(user))
  end
end
