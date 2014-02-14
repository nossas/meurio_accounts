MeurioAccounts::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/login' => "devise/sessions#new"
    get '/logout' => "devise/sessions#destroy"
    root to: 'devise/sessions#new'
  end

  resources :users, only: [:edit, :update, :show]

  get 'ssi_redirect' => 'users#ssi_redirect', as: :ssi_redirect
  get 'edit_profile' => 'users#edit', as: :edit_profile

  get 'validate_email' => "users#validate_email"
  post 'validate_email' => "users#validate_email"
end
