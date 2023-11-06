require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context 'GET /index' do
    let(:user) { User.create(name: 'Lily') }

    before :each do
      Post.create(author: user, title: 'Title')
      get user_posts_path(user)
    end

    it 'returns as a successful response if status is correct' do
      expect(response).to be_successful
    end

    it 'returns as http status 200 or response status is correct' do
      expect(response.status).to eq(200)
    end

    it 'renders as the right view file and the correct template' do
      expect(response).to render_template(:index)
    end

    it 'renders as the right placeholder which the response body includes correct placeholder text' do
      expect(response.body).to include('<h2>Lily</h2>')
      expect(response.body).to include('<p>Number of posts: 1</p>')
      expect(response.body).to include('<h3>Title</h3>')
      expect(response.body).to include('<p></p>')
      expect(response.body).to include(`<p class="counter">\nComments: 0, Likes: 0\n</p>`)
    end
  end

  context 'GET /show' do
    let(:user) { User.create(name: 'Lily') }
    let(:valid_attributes) { { 'author' => user, 'title' => 'Title' } }
    let(:post) { Post.create! valid_attributes }

    before :each do
      get "/users/:user_id/posts/#{post.id}"
    end

    it 'returns as a successful response if status is correct' do
      expect(response).to be_successful
    end

    it 'returns as http status 200 or response status is correct' do
      expect(response.status).to eq(200)
    end

    it 'renders as the right view file and the correct template' do
      expect(response).to render_template(:show)
    end

    it 'renders as the right placeholder which the response body includes correct placeholder text' do
      expect(response.body).to include('<h3>Title by Lily</h3>')
      expect(response.body).to include('<p></p>')
      expect(response.body).to include(`<p class="counter">\nComments: 0, Likes: 0\n</p>`)
    end
  end
end
