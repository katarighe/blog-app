require 'rails_helper'

RSpec.feature 'UserShows', type: :feature do
  let!(:user) { create(:user, name: 'Tom', bio: 'Teacher from Mexico', posts_counter: 3, photo: 'https://placehold.co/120x120') }
  scenario "I can see the user's profile picture" do
    visit user_path(user)
    expect(page).to have_css("img[src*='https://placehold.co/120x120']")
  end

  scenario "I can see the user's username" do
    visit user_path(user)
    expect(page).to have_content('Tom')
  end

  scenario 'I can see the number of posts the user has written' do
    visit user_path(user)
    expect(page).to have_content('Number of posts: 3')
  end

  scenario "I can see the user's bio" do
    visit user_path(user)
    expect(page).to have_content('Bio')
    expect(page).to have_content('Teacher from Mexico')
  end

  scenario "I can see a button to view all of a user's posts" do
    visit user_path(user)
    expect(page).to have_link('See All Posts', href: user_posts_path(user))
  end

  scenario "I can see the user's first 3 posts" do
    user_posts = create_list(:post, 3, author: user)
    visit user_path(user)
    user_posts.first(3).each do |post|
      expect(page).to have_content(post.title)
    end
  end

  scenario "When I click to see all posts, it redirects me to the user's post's index page" do
    visit user_path(user)
    click_link('See All Posts')
    expect(page).to have_current_path(user_posts_path(user))
  end
  
  scenario "When I click a user's post, it redirects me to that post's show page" do
    user_post = create(:post, author: user)
    visit user_path(user)
    click_link(user_post.title)
    expect(page).to have_current_path(user_post_path(user, user_post))
  end
end