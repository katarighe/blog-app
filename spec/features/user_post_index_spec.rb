require "rails_helper"

feature "User post index page" do
  scenario "I can see the user's profile picture" do
    visit user_posts_path(User.first)
    expect(page).to have_css("img.user-profile-picture")
  end

  scenario "I can see the user's username" do
    visit user_posts_path(User.first)
    expect(page).to have_css("h1.user-name")
  end

  scenario "I can see the number of posts the user has written" do
    visit user_posts_path(User.first)
    expect(page).to have_css("h2.user-post-count")
  end

  scenario "I can see a post's title" do
    visit user_posts_path(User.first)
    expect(page).to have_css("h3.post-title")
  end

  scenario "I can see some of the post's body" do
    visit user_posts_path(User.first)
    expect(page).to have_css("p.post-body")
  end

  scenario "I can see the first comments on a post" do
    visit user_posts_path(User.first)
    expect(page).to have_css("ul.comments-container li.comment")
  end

  scenario "I can see how many comments a post has" do
    visit user_posts_path(User.first)
    expect(page).to have_css("h3.comments-count")
  end

  scenario "I can see how many likes a post has" do
    visit user_posts_path(User.first)
    expect(page).to have_css("h3.likes-count")
  end

  scenario "I can see a section for pagination if there are more posts than fit on the view" do
    visit user_posts_path(User.first)
    expect(page).to have_css("div.pagination")
  end
end
