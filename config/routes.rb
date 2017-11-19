Rails.application.routes.draw do
  #devise_for :users - на будущее
  namespace :myapi do
    resources :users, only: [:index, :create]
    resources :auth, only: [:create]

    # Этот путь для создания базового юзверя 
    post 'auth/force'
  end
end
