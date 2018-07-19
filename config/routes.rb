Rails.application.routes.draw do
  resources :crpyto_infos
  root to: 'visitors#index'
end
