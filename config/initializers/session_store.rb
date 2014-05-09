# Be sure to restart your server when you modify this file.

if Rails.env.production?
  MeurioAccounts::Application.config.session_store :cookie_store, key: '_meurio_accounts_session', domain: 'meurio.org.br', expire_after: 100.years
elsif Rails.env.staging?
  MeurioAccounts::Application.config.session_store :cookie_store, key: '_meurio_accounts_session', domain: 'meurio-staging.org.br', expire_after: 100.years
else
  MeurioAccounts::Application.config.session_store :cookie_store, key: '_meurio_accounts_session', expire_after: 100.years
end
