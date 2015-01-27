CPDBoostTemplate::Application.routes.draw do
  
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  resources :posts do
    resources :votes
    resources :comments, only: [:create]
  end
  
  resources :users, only: [:create, :show, :edit, :update] do
    post :bookmark, on: :member
  end
  
  resources :categories, only: [:new, :create, :show]
  
  root to: 'posts#index'
  
end
