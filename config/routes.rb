Rails.application.routes.draw do
  resources :stodos do
    resources :sitems
  end
end