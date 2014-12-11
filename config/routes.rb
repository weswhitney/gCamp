Rails.application.routes.draw do

  resources :users

  resources :projects do
    resources :tasks do
      resources :comments
    end
    resources :memberships
  end


  root "pages#index"

  get 'about' => 'pages#about', as: :about
  get 'terms' => 'pages#terms', as: :terms
  get 'faq'   => 'pages#faq',   as: :faq
  get '/sign-up' => 'registrations#new', as: :signup
  post '/sign-up' => 'registrations#create'
  get '/sign-in' => 'authentication#new', as: :signin
  post '/sign-in' => 'authentication#create'
  get '/sign-out' => 'authentication#destroy', as: :signout
  get '/tracker_projects' => 'tracker_projects#show'
end
