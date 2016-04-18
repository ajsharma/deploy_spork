Rails.application.routes.draw do
  get "/auth/:provider/callback" => 'sessions#create'
  get "/signin" => 'sessions#new', :as => :signin
  get "/signout" => 'sessions#destroy', :as => :signout
  get "/auth/failure" => 'sessions#failure'

  root to: 'high_voltage/pages#show', id: 'about'
end
