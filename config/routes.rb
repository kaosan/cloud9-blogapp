Rails.application.routes.draw do
  root to: 'blogs#top'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  resources :blogs do
    collection do
      post :confirm
    end
  end

  resources :favorites, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
