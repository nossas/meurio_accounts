MeurioAccounts::Application.routes.draw do
  root 'casino/sessions#new'

  get '/sessions', to: redirect('/edit_profile')

  mount CASino::Engine => '/'

  devise_for :users

  resources :users, only: [:edit, :create, :update, :show]

  get 'ssi_redirect' => 'users#ssi_redirect', as: :ssi_redirect
  get 'edit_profile' => 'users#edit', as: :edit_profile

  match 'validate_email' => "users#validate_email", as: :validate_email, via: [:get, :post]
end
