MeurioAccounts::Application.routes.draw do
  mount CASino::Engine => 'casino', :as => 'casino'

  devise_for :users
  devise_scope :user do
    get '/login' => "devise/sessions#new"
    get '/logout' => "devise/sessions#destroy"
    root to: 'devise/sessions#new'
  end

  resources :users, only: [:edit, :create, :update, :show]

  get 'ssi_redirect' => 'users#ssi_redirect', as: :ssi_redirect
  get 'edit_profile' => 'users#edit', as: :edit_profile

  match 'validate_email' => "users#validate_email", as: :validate_email, via: [:get, :post]
end
