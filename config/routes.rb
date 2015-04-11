Rails.application.routes.draw do
  resources :pitches do
    member do
      put "like", to: "pitches#upvote"
      put "dislike", to: "pitches#downvote"
    end
end

  mount Upmin::Engine => '/admin'
  root to: 'pitches#index'
  devise_for :users
  resources :users
  get  '/users/sign_up(.:format)', to:'devise_invitable/registrations#new', as:'signup'

  get  '/users/sign_in(.:format)', to:'devise/sessions#new', as:'login'



end
