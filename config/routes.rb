Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get  '/users/sign_up(.:format)', to:'devise_invitable/registrations#new', as:'signup'

  get  '/users/sign_in(.:format)', to:'devise/sessions#new', as:'login'


  get  '/users/pitch', to:'users#pitch', as:'pitch'
  get '/users/pitches', to:'users#pitches', as:'pitches'

end
