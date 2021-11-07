class SprintsController < ApplicationController

    def show
        @sprint = Sprint.find_by_id(params[:id])
        @projeto = @sprint.projeto
        @colunas = @projeto.colunas
        @colunas_ids = @projeto.colunas.pluck(:id)
        @hash_quadros = {}
        @colunas_ids.each do |col|
            @hash_quadros[col] = {}
            @hash_quadros[col] = @colunas.find_by_id(col).quadros.where(sprint_id: @sprint.id)
        end
        @usuarios = Usuario.where(id: UsuarioProjeto.where(projeto_id: @projeto.id).pluck(:usuario_id))
    end

    def mover_tarefa
        @sprint = Sprint.find_by_id(params[:sprint])
        @projeto = Projeto.find_by_id(params[:projeto])
        @colunas = @projeto.colunas
        @coluna_atual = @projeto.colunas.find_by_id(params[:coluna_atual])
        @proximas_colunas = @projeto.colunas.where("id <> (?)", @coluna_atual.id)
        @quadro = @coluna_atual.quadros.find_by_id(params[:quadro])
        respond_to do |format|
            format.html
            format.js
        end
    end

    def atualiza_quadro
        @projeto = Projeto.find_by_id(params[:projeto])
        @sprint = @projeto.sprints.find_by_id(params[:sprint])
        @colunas = Coluna.where(id: params[:colunas])
        Quadro.find_by_id(params[:quadro]).update(coluna_id: params[:coluna_selecionada])
    end

    def adicionar_quadro
        @coluna = Coluna.find_by_id(params[:coluna])
        @quadro = Quadro.new
        @sprint = Sprint.find_by_id(params[:sprint])
    end

    def lista_prioridades
        @sprint = Sprint.find_by_id(params[:sprint_id])
        @quadros = @sprint.quadros.joins(:status).order('rank DESC, status.rank ASC')
    end

    def adicionar_novo_usuario
        @projeto = Projeto.find_by_id(params[:projeto_id])
    end

    def buscar_usuario
        @usuarios_projeto = Usuario.where(id: UsuarioProjeto.where(projeto_id: params[:projeto_id]).pluck(:usuario_id))
        @usuarios = Usuario.where('nome = :nome_email OR email = :nome_email', nome_email: params[:nome_email])
        @usuarios = @usuarios.reject{|usr| usr.in?(@usuarios_projeto) }
        @parametro_nome_email = params[:nome_email]
        @projeto = Projeto.find_by_id(params[:projeto_id])
    end

    def adicionar_usuario
        UsuarioProjeto.create(usuario_id: params[:usuario_id].to_i, projeto_id: params[:projeto_id].to_i)
        @usuarios = Usuario.where(id: UsuarioProjeto.where(projeto_id: params[:projeto_id]).pluck(:usuario_id))
        @projeto = Projeto.find_by_id(params[:projeto_id])
    end

end