require 'rails_helper'

RSpec.describe 'Posts', type: :request do
    context 'GET /index' do
        before :each do
            get '/users/:user_id/posts'
end

it 'returns a sucessful response' do
    expect(response).to be_sucessful
end

it 'returns as http status 200' do
    expect(response.status).to eq(200)
end

it 'renders the right view file' do
    expect(response).to render_template(:index)
end

it 'renders the right placeholder' do
    expect(response.body).to include('<h1>In this section, here is a list of the posts shown for a designated user.</h1>')
end
end

context 'GET /show' do
    let(:user) { User.create(name: 'Tom' ) }
    let(:valid_attributes) { {'author' => user, 'title' => 'Title' } }
    let(:post) { Post.create! valid_attributes }

    before :each do
        get "/users/:user_id/posts/#{post.id}"
    end

    it 'returns as a sucessful response' do
        expect(response).to be_sucessful
    end

    it 'returns as http status 200' do
        expect(response.status).to eq(200)
    end

    it 'renders as the right view file' do
        expect(response).to render_template(:show)
    end

    it 'renders as the right placeholder' do
        expect(response.body).to include('<h1>In this section, here is a selected post with for a designated user.</h1>')
    end
end
end