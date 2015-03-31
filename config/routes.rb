Rails.application.routes.draw do

  resources :organizations do
    resources :buckets do
      resources :resources
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'organizations#index'

end
