require 'rails_helper'

RSpec.describe 'When I open user show page', type: :system do
  before :all do
    FactoryBot.create_list(:user, 3)
    FactoryBot.create_list(:post, 4, author: User.first)
    FactoryBot.create_list(:post, 2, author: User.second)
  end

  it "shows the user's profile picture" do
    User.all.each do |user|
      visit user_path(user)
      sleep(1)
      expect(page).to have_css("img[src='#{user.photo}'")
    end
  end

  it "shows the user's username" do
    User.all.each do |user|
      visit user_path(user)
      sleep(1)
      expect(page).to have_content(user.name)
    end
  end

  it 'shows the number of posts the user has written' do
    User.all.each do |user|
      visit user_path(user)
      sleep(1)
      post_count = user.posts.count
      expect(page).to have_content("Number of posts: #{post_count}")
    end
  end

  it "shows the user's bio" do
    User.all.each do |user|
      visit user_path(user)
      sleep(1)
      expect(page).to have_content(user.bio)
    end
  end

  it "shows the user's latest 3 posts" do
    User.all.each do |user|
      visit user_path(user)
      sleep(1)
      latest_posts = user.posts.last(3)
      latest_posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end
  end

  it "shows a button that lets me view all of a user's posts" do
    User.all.each do |user|
      visit user_path(user)
      sleep(1)
      expect(page).to have_link('See all posts', href: "/users/#{user.id}/posts?page=1")
    end
  end

  context "When I click a user's post" do
    it "redirects me to that post's show page" do
      User.all.each do |user|
        latest_post = user.posts.last
        visit user_path(user)
        sleep(1)
        click_link(latest_post.title)
        sleep(1)
        expect(page).to have_current_path(user_post_path(user, latest_post))
      end
    end
  end

  context 'When I click to see all posts' do
    it "redirects me to the user's post's index page" do
      User.all.each do |user|
        visit user_path(user)
        sleep(1)
        click_link('See all posts')
        sleep(1)
        expect(page).to have_current_path("/users/#{user.id}/posts?page=1")
      end
    end
  end
end
