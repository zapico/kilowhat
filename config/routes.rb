Rails.application.routes.draw do

  
  resources :game
  resources :welcome
  resources :logs
  resources :kwhlogs
  resources :conversion
  
  root "welcome#index"
   
  get '/about' => 'welcome#about'
  get '/api' => 'welcome#api'
  post 'kwhlog', to: 'kwhlog#save',  param: :message
  get '/showlog' => 'log#show'
  get '/game' => 'game#index'
  get '/results' => 'game#results'
  get '/next' => 'game#next', as: 'next'
   
  get '/all.:format' => 'conversion#index'
  get '/data' => 'conversion#data'
  get '/:id.:format' => 'conversion#show'

  
end
