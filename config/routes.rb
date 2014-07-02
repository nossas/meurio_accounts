MeurioAccounts::Application.routes.draw do
  root 'casino/sessions#new'

  get '/sessions', to: redirect('/edit_profile')

  mount CASino::Engine => '/'

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users, only: [:edit, :create, :update, :show]

  get 'ssi_redirect' => 'users#ssi_redirect', as: :ssi_redirect
  get 'profile' => 'users#edit', as: :edit_profile
  get 'sign_in_after_sign_up' => 'users#sign_in', as: :sign_in_after_sign_up

  match 'validate_email' => "users#validate_email", as: :validate_email, via: [:get, :post]
end
