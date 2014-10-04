Taskle::Application.routes.draw do

   devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  
  resources :users 

  resources :todos do 
    resources :items, only: [:create, :destroy]
  end

  root to: 'application#index'

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

end
