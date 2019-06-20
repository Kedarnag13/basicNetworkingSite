Rails.application.routes.draw do
  root 'welcome#index'
  get '/search' => 'welcome#search', as: :search_by_content
  resources :members do
    member do
      put :add_as_friend
      put :remove_friend
    end
  end
  resources :sessions
end
