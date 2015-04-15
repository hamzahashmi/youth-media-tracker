Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :comments

  resources :pitches do
    member do
      put "like", to: "pitches#upvote"
      put "dislike", to: "pitches#downvote"
    end
    resources :comments
end

  mount Upmin::Engine => '/admin'
  root to: 'pitches#index'
  devise_for :users
  resources :users
  get  '/users/sign_up(.:format)', to:'devise_invitable/registrations#new', as:'signup'

  get  '/users/sign_in(.:format)', to:'devise/sessions#new', as:'login'



end
