require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  scenario "I can see the user's profile picture" do
    visit user_path(@user)
    expect(page).to have_css('.user img.profile-picture')
  end

  scenario "I can see the user's username" do
    visit user_path(@user)
    expect(page).to have_content(@user.username)
  end

  scenario "I can see the number of posts the user has written" do
    visit user_path(@user)
    expect(page).to have_content("Posts: " + @user.posts.count.to_s)
  end

  scenario "I can see the user's bio" do
    visit user_path(@user)
    expect(page).to have_css('#user-biography h3', text: 'Biography')
    expect(page).to have_content(@user.bio)
  end

  scenario "I can see the user's first 3 posts" do
    visit user_path(@user)
    @user.three_most_recent_posts.each do |post|
      expect(page).to have_link(post.title, href: user_post_path(@user, post))
    end
  end

  scenario "I can see a button that lets me view all of a user's posts" do
    visit user_path(@user)
    expect(page).to have_link('See all posts', href: user_posts_path(@user, page: 1))
  end

  scenario "When I click a user's post, it redirects me to that post's show page" do
    visit user_path(@user)
    @user.three_most_recent_posts.each do |post|
      find("#post_#{post.id}").click
      expect(current_path).to eq(user_post_path(@user, post))
      visit user_path(@user)
    end
  end

  scenario "When I click to see all posts, it redirects me to the user's post's index page" do
    visit user_path(@user)
    click_link('See all posts')
    expect(current_path).to eq(user_posts_path(@user, page: 1))
  end
end
