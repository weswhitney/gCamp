Rails.application.routes.draw do

  resources :tasks

  resources :users

  resources :projects

  root "pages#index"

  get 'about' => 'pages#about', as: :about
  get 'terms' => 'pages#terms', as: :terms
  get 'faq'   => 'pages#faq',   as: :faq
  get '/sign-up' => 'registrations#new', as: :signup
  post '/sign-up' => 'registrations#create'
  get '/sign-in' => 'authentication#new', as: :signin
  post '/sign-in' => 'authentication#create'
  get '/sign-out' => 'authentication#destroy', as: :signout
end
