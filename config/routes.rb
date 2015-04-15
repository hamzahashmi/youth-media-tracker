Rails.application.routes.draw do

  get '/pitches/search' => 'pitches#search', as: 'search'

  resources :pitches

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get  '/users/sign_up(.:format)', to:'devise_invitable/registrations#new', as:'signup'

  get  '/users/sign_in(.:format)', to:'devise/sessions#new', as:'login'



end
