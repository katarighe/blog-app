require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before do
    visit "/users/#{user.id}"
  end

  it 'shows the user\'s profile picture' do
    expect(page).to have_css("img[src='#{user.photo}']")
  end

  it 'shows the user\'s username' do
    expect(page).to have_content(user.name)
  end

  it 'shows the number of posts the user has written' do
    expect(page).to have_content("Posts: #{user.posts.count}")
  end

  it 'shows the user\'s bio' do
    expect(page).to have_content(user.bio)
  end

  it 'shows the user\'s first 3 posts' do
    expect(page).to have_css('#user-biography li', count: 3)
  end

  it 'shows a button that lets me view all of a user\'s posts' do
    expect(page).to have_link('See all posts', href: "/users/#{user.id}/posts?page=1")
  end

  it 'redirects to a post\'s show page when I click a user\'s post' do
    first_post = user.posts.first
    click_on first_post.title
    expect(current_path).to eq("/users/#{user.id}/posts/#{first_post.id}")
  end

  it 'redirects to the user\'s post\'s index page when I click to see all posts' do
    click_on 'See all posts'
    expect(current_path).to eq("/users/#{user.id}/posts")
  end
end
