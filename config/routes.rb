require 'api_constraints'
Cheersee::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => 'api/v1/users', :sessions => 'api/v1/sessions'}
  #API definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :profiles, :only => [:show, :update]
      resources :contests, :only => [:index, :create, :update, :destroy] 
      resources :clink_comments do
        resources :c_comments, :only => [:create, :update, :destroy]
      end
      resources :clink_likes do
        resources :c_likes, :only => [:create, :destroy]
      end
      resources :participations, :only => [:index, :create, :update, :destroy]
      resources :plink_comments do
        resources :p_comments, :only => [:create, :update, :destroy]
      end
      resources :plink_likes do
        resources :p_likes, :only => [:create, :destroy]
      end
      resources :feeds, :only => [:index, :show]
      get "/feeds/:id/:contest_id", to: "feeds#association"
    end
  end
end