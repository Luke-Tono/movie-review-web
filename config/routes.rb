Rails.application.routes.draw do
  root 'movies#index'
  
  # 用户认证
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # 用户资源
  resources :users, except: [:index, :destroy]
  
  # 个人资料
  resources :profiles, only: [:edit, :update]
  
  # 电影资源
  resources :movies
  
  # 观影清单资源
  resources :watchlists do
    member do
      post 'add_movie/:movie_id', to: 'watchlists#add_movie', as: 'add_movie'
      delete 'remove_movie/:movie_id', to: 'watchlists#remove_movie', as: 'remove_movie'
    end
  end
  
  # 嵌套资源
  resources :movies do
    resources :reviews, only: [:create]
  end
  
  resources :reviews, only: [:edit, :update, :destroy] do
    resources :comments, only: [:create]
  end
  
  resources :comments, only: [:destroy]
end