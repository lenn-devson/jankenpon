Rails.application.routes.draw do
  resources :elements
  get :setup, to: 'game#setup'
  post :setup, to: 'game#init'
  get :play, to: 'game#play'
  post :evaluate, to: 'game#evaluate'

  root 'game#setup'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
