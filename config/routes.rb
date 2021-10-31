Rails.application.routes.draw do
  resources :home, only: :index
  resources :projetos
  resources :usuarios

  # Application
  get 'sair', to: 'application#sair', as: :sair

  # Usuarios
  post 'logar',to: 'usuarios#logar', as: :logar
  get  'login',to: 'usuarios#login', as: :login

  # Rota inicial
  root :to => 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
