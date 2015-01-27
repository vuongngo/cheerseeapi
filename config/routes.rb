require 'api_constraints'
Cheersee::Application.routes.draw do
  devise_for :users
  #API definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :profiles, :only => [:show, :update]
    end
  end
end