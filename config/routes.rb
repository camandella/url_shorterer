Rails.application.routes.draw do
  resources :urls, only: [:create, :show] do
    get :stats, on: :member
  end
end
