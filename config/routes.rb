Rails.application.routes.draw do
  root 'welcome#index'
  resources :members do
    member do
      put :add_as_friend
      put :remove_friend
    end
  end
  resources :sessions
end
