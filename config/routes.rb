Rails.application.routes.draw do
  root 'welcome#index'
  get '/search' => 'welcome#search', as: :search_by_content
  # get '/my_profile' => 'members#my_profile', as: :my_profile
  resources :members do
    member do
      put :add_as_friend
      put :remove_friend
    end
    collection do
      get :my_profile
      get :search
    end
  end
  resources :sessions
end
