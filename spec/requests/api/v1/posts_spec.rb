require 'swagger_helper'

describe 'Posts API' do
  path '/api/v1/users/{id}' do
    get "Retrieves a user's posts" do
      tags 'Posts'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'user found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 bio: { type: :string },
                 photo: { type: :string },
                 posts: { type: :object,
                          properties: {
                            id: { type: :integer },
                            title: { type: :string },
                            text: { type: :string }
                          } }
               },
               required: %w[id name posts]

        let(:id) { Post.create(title: 'Rails', author_id: 1, text: 'Information...').id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end