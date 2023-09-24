Rails.application.routes.draw do
  resources :albums
  resources :playlists
  devise_for :artists
  root 'pages#home'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
