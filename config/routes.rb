Rails.application.routes.draw do
  resources :crpyto_infos
  root to: 'visitors#index'
  # post '/update-country-details', to: 'user_info#update_country', as:'update_country'

  post '/ticker-info', to: 'crpyto_infos#get_ti'

  # Should be at the bottom
  match '*path' => redirect('/'), via: [:get, :post] unless Rails.env.development?
end
