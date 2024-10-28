Rails.application.routes.draw do
  get 'collection_navigation/index'
  resources :dogs
  resources :owners
  resources :vet_visits
  resources :dogs, only: [:index, :show]

  resources :animal_adoptions, only: [:index, :show]
  resources :breeds, only: [:index, :show], path: '/breeds'


  root 'pages#home' # Set the root path to 'pages#home'
  get '/search', to: 'pages#search'

  get '/about_us', to: 'pages#about_us', as: 'about_us'
  get 'collection_navigation', to: 'collection_navigation#index', as: 'collection_navigation'
  get '/animal_adoptions', to: 'animal_adoptions#index'
end
