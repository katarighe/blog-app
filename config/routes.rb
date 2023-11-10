Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'users#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'login#index', as: :unauthenticated_root
    end
  end

  get '/login', to: 'login#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
  
  delete 'posts/:id', to: 'posts#destroy', as: :destroy_post
    namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts do
          get 'comments', to: 'comments#comments_for_post'
        end
      end
      root 'users#index'
    end
  end
end