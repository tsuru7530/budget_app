Rails.application.routes.draw do
  root to: "districts#index"
  resources :districts
  resources :incomes
  resources :outgoes
end
