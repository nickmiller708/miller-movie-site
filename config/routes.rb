Rails.application.routes.draw do
    
  #Admin Pages (Creating users and setting session user)
  resources :user_admins
  get '/admin', to: 'user_admins#admin_homepage', as: :admin_homepage
  get '/admin/login', to: 'user_admins#login', as: :admin_login
  post '/admin/process_login', to: 'user_admins#process_login', as: :process_login
  get '/admin/sign_out', to: 'user_admins#sign_out', as: :sign_out
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
    root 'welcome#index'
    get '/resume', to: 'welcome#resume', as: :resume
  get '/contact_me', to: 'welcome#contact_me', as: :contact_me
  # You can have the root of your site routed with "root"
    resources 'movie_site'

end
