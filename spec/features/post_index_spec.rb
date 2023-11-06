require 'rails_helper'
require './spec/features/placeholder'

RSpec.describe 'When I open user index page', type: :system do
  include TestPlaceholders
  before :all do
    Like.delete_all
    Comment.delete_all
    Post.delete_all
    User.delete_all
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Software engineer from Haiti')
    @second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'Math teacher from Belgium.')
    @third_user = User.create(name: 'Alan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Pastor and responsible of a church.')

    @first_post = Post.create(author: @first_user, title: 'First Post', text: placeholder)

    (1..10).each do |i|
      Post.create(author: @first_user, title: "Post ##{i}")
    end

    @index = 1
    (1..6).each do
      Comment.create(post: @first_post, user: @second_user, text: "Comment ##{@index}")
      @index += 1
      Comment.create(post: @first_post, user: @third_user, text: "Comment ##{@index}")
      @index += 1
    end

    10.times { Like.create(post: @first_post, user: @third_user) }
    10.times { Like.create(post: @first_post, user: @second_user) }
  end

  it "I can see the user's profile picture." do
    visit "/users/#{@first_user.id}/posts?page=1"
    sleep(1)
    expect(page).to have_css("img[src='#{@first_user.photo}']")
  end

  it "I can see the user's username." do
    visit "/users/#{@first_user.id}/posts?page=1"
    sleep(1)
    expect(page).to have_content('Tom')
  end

  it 'I can see the number of posts the user has written.' do
    visit "/users/#{@first_user.id}/posts?page=1"
    sleep(1)
    expect(page).to have_content('Number of posts: 11')
  end

  it "I can see a post's title." do
    visit "/users/#{@first_user.id}/posts?page=1"
    sleep(1)
    expect(page).to have_content('First Post')
    expect(page).to have_content('Post #1')
    expect(page).to have_content('Post #2')
    expect(page).to have_content('Post #3')
    expect(page).to have_content('Post #4')
  end

  it "I can see some of the post's body." do
    visit "/users/#{@first_user.id}/posts?page=1"
    string = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt lab...'
    sleep(1)
    expect(page).to have_content(string)
  end

  it 'I can see the first comments on a post.' do
    visit "/users/#{@first_user.id}/posts?page=1"
    sleep(1)
    expect(page).to have_content('Alan: Comment #8')
    expect(page).to have_content('Lilly: Comment #9')
    expect(page).to have_content('Alan: Comment #10')
    expect(page).to have_content('Lilly: Comment #11')
    expect(page).to have_content('Alan: Comment #12')
  end

  it 'I can see how many comments a post has.' do
    visit "/users/#{@first_user.id}/posts?page=1"
    sleep(1)
    expect(page).to have_content('Comments: 12')
  end

  it 'I can see how many likes a post has.' do
    visit "/users/#{@first_user.id}/posts?page=1"
    sleep(1)
    expect(page).to have_content('Likes: 20')
  end

  it 'I can see a section for pagination if there are more posts than fit on the view.' do
    visit "/users/#{@first_user.id}/posts?page=1"
    sleep(1)
    expect(page).to have_link('2', href: "/users/#{@first_user.id}/posts?page=2")
  end

  context 'When I click on a post, it redirects me to that post\'s show page.' do
    it "redirects me to that post's show page" do
      visit "/users/#{@first_user.id}/posts?page=1"
      sleep(1)
      click_link('First Post')
      expect(page).to have_current_path(user_post_path(@first_user, @first_post))
    end
  end
end
