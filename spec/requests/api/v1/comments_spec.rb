require 'swagger_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  describe 'Comments API' do
    path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
      get 'Retrieves comments for a specific post' do
        tags 'Comments'
        parameter name: :user_id, in: :path, type: :string
        parameter name: :post_id, in: :path, type: :string

        response '200', 'comments retrieved' do
          let(:user) { create(:user) }
          let(:post) { create(:post, author: user) }
          let(:user_id) { user.id }
          let(:post_id) { post.id }

          examples 'application/json' => [
            {
              id: 1,
              text: 'Comment 1 text',
              author_id: 1,
              post_id: 1
            },
            {
              id: 2,
              text: 'Comment 2 text',
              author_id: 2,
              post_id: 1
            }
            # Add more comment examples here if needed
          ]

          run_test!
        end

        post 'Creates a comment' do
          tags 'Comments'
          consumes 'application/json'
          parameter name: :user_id, in: :path, type: :string
          parameter name: :post_id, in: :path, type: :string
          parameter name: :comment, in: :body, schema: {
            type: :object,
            properties: {
              text: { type: :string },
              author_id: { type: :integer },
              post_id: { type: :integer }
              # Add other comment parameters here
            },
            required: %w[text author_id post_id] # Specify required fields
          }

          response '201', 'comment created' do
            let(:user) { create(:user) }
            let(:post) { create(:post, author: user) }
            let(:user_id) { user.id }
            let(:post_id) { post.id }
            let(:comment) { { text: 'Example Comment', author_id: user.id, post_id: post.id } }

            examples 'application/json' => {
              id: 3,
              text: 'Example Comment',
              author_id: 1,
              post_id: 1
            }

            run_test!
          end

          response '422', 'Invalid request' do
            let(:user) { create(:user) }
            let(:post) { create(:post, author: user) }
            let(:user_id) { user.id }
            let(:post_id) { post.id }
            let(:comment) { { text: nil, author_id: user.id, post_id: post.id } }

            run_test!
          end
        end
      end
    end
  end
end
