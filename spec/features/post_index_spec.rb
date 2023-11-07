require 'rails_helper'
require './spec/features/placeholder'

RSpec.describe 'When I open user index page', type: :system do
  include TestPlaceholders
  before :all do
    FactoryBot.create_list(:post, 10)
    FactoryBot.create_list(:comment, 12)
    FactoryBot.create_list(:like, 20)
  end

  it "I can see the user's profile picture." do
    user = FactoryBot.create(:user, name: 'Tom')
    visit "/users/#{user.id}/posts?page=1"
    sleep(1)
    expect(page).to have_css("img[src='#{user.photo}'")
  end

  it "I can see the user's username." do
    user = FactoryBot.create(:user, name: 'Tom')
    visit "/users/#{user.id}/posts?page=1"
    sleep(1)
    expect(page).to have_content(user.name)
  end

  # ... other tests

  it 'I can see a section for pagination if there are more posts than fit on the view.' do
    user = FactoryBot.create(:user)
    visit "/users/#{user.id}/posts?page=1"
    sleep(1)
    expect(page).to have_link('2', href: "/users/#{user.id}/posts?page=2")
  end

  context 'When I click on a post, it redirects me to that post\'s show page.' do
    it "redirects me to that post's show page" do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, author: user, title: 'First Post')
      visit "/users/#{user.id}/posts?page=1"
      sleep(1)
      click_link('First Post')
      expect(page).to have_current_path(user_post_path(user, post))
    end
  end
end
