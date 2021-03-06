Rails.application.routes.draw do

  controller :sessions do
    get 'login', action: :new
    post 'login', action: :create
    delete 'logout', action: :destroy
  end
  namespace :admin do
    resources :users do
      post :confirm,action: :confirm_new,on: :new
      # post :confirm,action: :confirm_new,on: :edit
    end
  end
  root to: 'tasks#index'
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
