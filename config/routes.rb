Rails.application.routes.draw do
  resources :contacts
  root to: 'blogs#top'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  resources :blogs do
    collection do
      post :confirm
    end
  end

  resources :favorites, only: [:create, :destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
