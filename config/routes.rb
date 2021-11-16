Rails.application.routes.draw do
  resources :home, only: :index
  resources :projetos
  resources :usuarios
  resources :sprints
  resources :quadros
  resources :statuses
  resources :perfils
  resources :funcionalidades
  resources :empresas
  resources :colunas

  # Home
  get 'gerenciamento', to: 'home#gerenciamento', as: :gerenciamento

  # Application
  get 'sair', to: 'application#sair', as: :sair

  # Usuario
  post 'logar', to: 'usuarios#logar', as: :logar
  get  'login', to: 'usuarios#login', as: :login
  
  # Sprint
  get  'mover_tarefa',           to: 'sprints#mover_tarefa',           as: :mover_tarefa
  get  'atualiza_quadro',        to: 'sprints#atualiza_quadro',        as: :atualiza_quadro
  get  'adicionar_quadro',       to: 'sprints#adicionar_quadro',       as: :adicionar_quadro
  get  'lista_prioridades',      to: 'sprints#lista_prioridades',      as: :lista_prioridades
  get  'adicionar_novo_usuario', to: 'sprints#adicionar_novo_usuario', as: :adicionar_novo_usuario
  post 'buscar_usuario',         to: 'sprints#buscar_usuario',         as: :buscar_usuario
  get  'adicionar_usuario',      to: 'sprints#adicionar_usuario',      as: :adicionar_usuario
  get  'assumir_tarefa',         to: 'sprints#assumir_tarefa',         as: :assumir_tarefa
  get  'deixar_tarefa',          to: 'sprints#deixar_tarefa',          as: :deixar_tarefa
  get  'next_prioridade',        to: 'sprints#next_prioridade',        as: :next_prioridade
  
  # Perfil
  get  'adicionar_funcionalidade',        to: 'perfils#adicionar_funcionalidade',        as: :adicionar_funcionalidade
  post 'adicionar_funcionalidade_perfil', to: 'perfils#adicionar_funcionalidade_perfil', as: :adicionar_funcionalidade_perfil

  # Projeto
  get  'backlog', to: 'projetos#backlog', as: :backlog

  # Rota inicial
  root :to => 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
