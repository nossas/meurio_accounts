MeurioAccounts::Application.routes.draw do
  get '/sessions', to: redirect('/edit_profile')

  mount CASino::Engine => '/'

  devise_for :users

  resources :users, only: [:edit, :create, :update, :show]

  get 'ssi_redirect' => 'users#ssi_redirect', as: :ssi_redirect
  get 'edit_profile' => 'users#edit', as: :edit_profile

  get 'validate_email' => "users#validate_email"
  post 'validate_email' => "users#validate_email"
end
