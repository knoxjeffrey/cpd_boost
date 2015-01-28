CPDBoostTemplate::Application.routes.draw do
  
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  # Gav used this for testing
  # get "/posts/:post_id/votes" => 'votes#create'
  
  resources :posts do
    resources :votes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:create, :show, :edit, :update] do
    post :bookmark, on: :member
    delete :remove_bookmark, on: :member
  end
  
  resources :categories, only: [:new, :create, :show]
  
  root to: 'posts#index'
  
end
