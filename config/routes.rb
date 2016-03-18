Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#index'

  resources :users do
    member do
      post 'create_book'
      delete 'destroy_book'
    end
  end

end
