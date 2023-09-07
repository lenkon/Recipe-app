Rails.application.routes.draw do
  # get 'landing_page/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "landing_page#index"
  
  resources :recipes
  resources :foods
  resources :recipe_foods
end
