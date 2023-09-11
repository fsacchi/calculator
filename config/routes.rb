Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'calculator#index'
  get '/calculator/concat_text', to: 'calculator#concat_text', as: 'concat_text_calculator'
  get '/calculator/reset_text', to: 'calculator#reset_text', as: 'reset_text_calculator'
  get '/calculator/operation', to: 'calculator#operation', as: 'operation_calculator'
  get '/calculator/equals', to: 'calculator#equals', as: 'equals_calculator'
  get '/calculator', to: 'calculator#index'

end
