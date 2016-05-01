Rails.application.routes.draw do
  resource :heroku_deploys, only: [:create]
  root to: "high_voltage/pages#show", id: "about"
end
