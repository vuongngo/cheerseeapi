require 'api_constraints'
Cheersee::Application.routes.draw do
  devise_for :users
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
      resources :main_pages, :only => [:index, :show]
      get "/main_pages/:id/:contest_id", to: "main_pages#association"
    end
  end
end