Rails.application.routes.draw do

  resources :organizations do
    get "all_resources"
    get "archived_resources"
    get "approved_resources"
    get "unread_resources"
    resources :contributors
    resources :buckets do
      resources :resources do
        resources :readings, only: [:create, :destroy]
        resources :tweets
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'organizations#index'

end
