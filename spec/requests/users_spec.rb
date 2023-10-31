require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context 'GET /index' do
    before :each do
      get users_path
    end

    it 'returns as a successful response' do
      expect(response).to be_successful
    end

    it 'returns as http status 200' do
      expect(response.status).to eq(200)
    end

    it 'renders as the right view file' do
      expect(response).to render_template(:index)
    end

    it 'renders as the right placeholder' do
      expect(response.body).to include('<h1>In this section, here is a list of users.</h1>')
    end
  end

  context 'GET /show' do
    let(:valid_attributes) { { 'name' => 'Lily' } }
    let(:user) { User.create! valid_attributes }
    before :each do
        get user_url(user)
    end

    it 'returns as a successful response' do
      expect(response).to be_successful
    end

    it 'returns as http status 200' do
      expect(response.status).to eq(200)
    end

    it 'renders as the right view file' do
      expect(response).to render_template(:show)
    end

    it 'renders as the right placeholder' do
      expect(response.body).to include('<h1>In this section, here is a selected user from the list.</h1>')
    end
  end
end