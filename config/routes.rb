Rails.application.routes.draw do
  root to: "districts#index"
  resources :districts
  get "/search", to: "districts#search"
  resources :incomes do
    resources :outgoes
  end
end
