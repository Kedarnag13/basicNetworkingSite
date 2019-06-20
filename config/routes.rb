Rails.application.routes.draw do
  root 'welcome#index'
  resources :members
  resources :sessions
end
