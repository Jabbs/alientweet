Rails.application.routes.draw do

  devise_for :users
  resources :organizations do
    get "twitter_analysis"
    get "all_resources"
    get "archived_resources"
    get "approved_resources"
    get "unread_resources"
    get "tweet_manager"
    get "tweets_to_send"
    get "sent_tweets"
    put "clear_all_tweets"
    resources :activities
    resources :contributors
    resources :buckets do
      resources :resources do
        resources :comments, only: [:create]
        resources :readings, only: [:create, :destroy]
        resources :tweets do
          put 'move'
          resources :comments, only: [:create]
        end
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'organizations#index'

end
