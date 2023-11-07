require 'rails_helper'

RSpec.describe 'When I open user show page', type: :system do
  before :all do
    FactoryBot.create_list(:comment, 6)
    FactoryBot.create_list(:like, 20)
  end

  it "I can see the post's title." do
    post = FactoryBot.create(:post, title: 'Latest Post', text: 'This is my latest post')
    visit user_post_path(post.author, post)
    sleep(1)
    expect(page).to have_content('Latest Post')
  end

  it 'I can see who wrote the post.' do
    user = FactoryBot.create(:user, name: 'Tom')
    post = FactoryBot.create(:post, author: user)
    visit user_post_path(user, post)
    sleep(1)
    expect(page).to have_content("by #{user.name}")
  end

  it 'I can see how many comments it has.' do
    post = FactoryBot.create(:post)
    FactoryBot.create_list(:comment, 6, post:)
    visit user_post_path(post.author, post)
    sleep(1)
    expect(page).to have_content('Comments: 6')
  end

  it 'I can see how many likes it has.' do
    post = FactoryBot.create(:post)
    FactoryBot.create_list(:like, 20, post:)
    visit user_post_path(post.author, post)
    sleep(1)
    expect(page).to have_content('Likes: 20')
  end

  it 'I can see the post body.' do
    post = FactoryBot.create(:post, text: 'This is my latest post')
    visit user_post_path(post.author, post)
    sleep(1)
    expect(page).to have_content('This is my latest post')
  end

  it 'I can see the username of each commentor.' do
    post = FactoryBot.create(:post)
    users = FactoryBot.create_list(:user, 2, name: %w[Lilly Alan])
    FactoryBot.create_list(:comment, 6, post:, user: users)
    visit user_post_path(post.author, post)
    sleep(1)
    expect(page).to have_text('Lilly:', count: 3)
    expect(page).to have_text('Alan:', count: 3)
  end

  it 'I can see the comment each commentor left.' do
    post = FactoryBot.create(:post)
    comments = FactoryBot.create_list(:comment, 6, post:)
    visit user_post_path(post.author, post)
    sleep(1)
    comments.each_with_index do |_comment, i|
      expect(page).to have_content("Comment ##{i + 1}")
    end
  end
end
