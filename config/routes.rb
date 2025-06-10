Rails.application.routes.draw do
  root to: "districts#index"
  resources :districts
end
