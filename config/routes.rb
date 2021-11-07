Rails.application.routes.draw do
  resources :home, only: :index
  resources :projetos
  resources :usuarios
  resources :sprints
  resources :quadros

  # Application
  get 'sair', to: 'application#sair', as: :sair

  # Usuario
  post 'logar', to: 'usuarios#logar', as: :logar
  get  'login', to: 'usuarios#login', as: :login
  
  # Sprint
  get  'mover_tarefa',      to: 'sprints#mover_tarefa',      as: :mover_tarefa
  get  'atualiza_quadro',   to: 'sprints#atualiza_quadro',   as: :atualiza_quadro
  get  'adicionar_quadro',  to: 'sprints#adicionar_quadro',  as: :adicionar_quadro
  get  'lista_prioridades', to: 'sprints#lista_prioridades', as: :lista_prioridades
  
  # Projeto
  get  'backlog', to: 'projetos#backlog', as: :backlog

  # Rota inicial
  root :to => 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
