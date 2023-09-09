Rails.application.routes.draw do
  devise_for :users
  root "landing_page#index"
  
  get 'recipes/public_recipes'
  resources :recipes do
    resources :recipe_foods
    member do
      get 'general_shopping_list', to: 'recipe_foods#index', as: 'general_shopping_list'
    end
  end
  resources :foods  
end
