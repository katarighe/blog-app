require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  let!(:user1) { create(:user, name: 'Tom', photo: 'https://placehold.co/120x120') }
  let!(:user2) { create(:user, name: 'Binod', photo: 'https://placehold.co/120x120') }
  let!(:user3) { create(:user, name: 'Lilly', photo: 'https://placehold.co/120x120') }

  scenario 'I can see the username of all other users' do
    visit users_path
    expect(page).to have_content(user1.name.to_s)
    expect(page).to have_content(user2.name.to_s)
    expect(page).to have_content(user3.name.to_s)
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path
    expect(page).to have_css("img[src*='https://placehold.co/120x120']")
    expect(page).to have_css("img[src*='https://placehold.co/120x120']")
    expect(page).to have_css("img[src*='https://placehold.co/120x120']")
  end

  scenario 'I can see the number of posts each user has written' do
    create_list(:post, 3, author: user1)
    create_list(:post, 5, author: user2)
    create_list(:post, 2, author: user3)

    visit users_path
    expect(page).to have_content("Number of posts: #{user1.posts.count}", count: 1)
    expect(page).to have_content("Number of posts: #{user2.posts.count}", count: 1)
    expect(page).to have_content("Number of posts: #{user3.posts.count}", count: 1)
  end

  scenario 'When I click on a user, I am redirected to that users show page' do
    visit users_path
    click_link(user1.name)
    expect(current_path).to eq(user_path(user1))
    expect(page).to have_content(user1.name.to_s)
  end
end