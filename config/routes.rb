Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :users
  get  '/users/sign_up(.:format)', to:'devise_invitable/registrations#new', as:'signup'

  get  '/users/sign_in(.:format)', to:'devise/sessions#new', as:'login'



end
