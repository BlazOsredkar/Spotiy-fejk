Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :songs do
    get 'add_to_playlist', on: :member
    post 'create_playlist_song', on: :member
  end

  delete 'playlists/:playlist_id/remove_song/:song_id', to: 'playlists#remove_from_playlist', as: :remove_from_playlist
  resources :albums
  resources :playlists
  root 'home#home'
  resources :users, only: [:show]
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
