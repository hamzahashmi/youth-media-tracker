Rails.application.routes.draw do
  resources :schedule, only: :create
  ActiveAdmin.routes(self)
  
  resources :schedule, only: :create

  resources :pitches do
    member do
      put "like", to: "pitches#upvote"
      put "dislike", to: "pitches#downvote"
    end
    resources :comments
end

  root to: 'pitches#index'
  #devise_for :users
  devise_for :users, controllers: { sessions: "users/sessions" }
  resources :users
  get  '/users/sign_up(.:format)', to:'devise_invitable/registrations#new', as:'signup'

  get  '/users/sign_in(.:format)', to:'devise/sessions#new', as:'login'

  get  '/about', to:'pages#about', as:'about'


end
