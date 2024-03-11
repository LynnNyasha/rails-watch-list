Rails.application.routes.draw do
  resources :lists do
    resources :bookmarks, only: [:create]
  end

  resources :movies, only: [:index, :show]
  resources :bookmarks, only: [:new]
  resources :bookmarks, only: [:destroy]
end
