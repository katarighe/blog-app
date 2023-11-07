require 'rails_helper'

RSpec.describe 'When I open user index page', type: :system do
  before :all do
    FactoryBot.create_list(:user, 3)
    FactoryBot.create_list(:post, 2, author: User.first)
    FactoryBot.create_list(:post, 1, author: User.second)
  end

  it 'should have 3 users' do
    visit users_path
    sleep(1)

    expect(page.all('ul#users_container li').size).to eq(3)
  end

  it 'shows the username of all other users' do
    visit users_path
    sleep(1)

    User.all.each do |user|
      expect(page).to have_text(user.name)
    end
  end

  it 'shows the profile picture for each user' do
    visit users_path
    sleep(1)

    User.all.each do |user|
      expect(page).to have_css("img[src='#{user.photo}'")
    end
  end

  it 'shows the number of posts each user has written' do
    visit users_path
    sleep(1)

    User.all.each do |user|
      post_count = user.posts.count
      expect(page).to have_content("Number of posts: #{post_count}")
    end
  end

  context 'When I click on a user' do
    User.all.each do |user|
      it "redirects to the user's show page" do
        visit users_path
        sleep(1)
        click_link(user.name)
        sleep(1)
        expect(page).to have_current_path(user_path(user))
      end
    end
  end
end
