Rails.application.routes.draw do
  # resources :conditions
  # resources :resorts
  # resources :states
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/states', to: 'states#index'

  get '/conditions', to: 'conditions#index'

  get '/resorts', to: 'resorts#index'
  get '/resorts/:state_id/:filter', to: 'resorts#filter'

  
end
