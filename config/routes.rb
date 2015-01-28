require 'api_constraints'
Cheersee::Application.routes.draw do
  devise_for :users
  #API definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :profiles, :only => [:show, :update]
      resources :contests, :only => [:index, :create, :update, :destroy] do
        resources :c_comments, :only => [:create, :update, :destroy]
      end
      resources :participations, :only => [:index, :create, :update, :destroy]
      resources :main_pages, :only => [:index, :show]
      get "/main_pages/:id/:contest_id", to: "main_pages#association"
    end
  end
end