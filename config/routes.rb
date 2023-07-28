# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users
  resources :prompts do 
    resources :conversations, except: [:update, :edit, :index] do
      resources :messages, only: [:create]
    end 
  end 
  root "prompts#index"
end
