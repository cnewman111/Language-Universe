# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :prompts do 
    resources :conversations
  end 
  root "prompts#index"
end
