class SprintsController < ApplicationController

    def show
        @sprint = Sprint.find_by_id(params[:id])
        @projeto = @sprint.projeto
        @colunas = @projeto.colunas
        carrega_quadros()
        @usuarios = Usuario.where(id: UsuarioProjeto.where(projeto_id: @projeto.id).pluck(:usuario_id))
    end

    def mover_tarefa
        @sprint = Sprint.find_by_id(params[:sprint])
        @projeto = Projeto.find_by_id(params[:projeto])
        @colunas = @projeto.colunas
        @coluna_atual = @projeto.colunas.find_by_id(params[:coluna_atual])
        @proximas_colunas = @projeto.colunas.where("id <> (?)", @coluna_atual.id)
        @quadro = @coluna_atual.quadros.find_by_id(params[:quadro])
        carrega_quadros()
        respond_to do |format|
            format.html
            format.js
        end
    end

    def atualiza_quadro
        @projeto = Projeto.find_by_id(params[:projeto])
        @sprint = @projeto.sprints.find_by_id(params[:sprint])
        @colunas = Coluna.where(id: params[:colunas])
        @quadro = Quadro.find_by_id(params[:quadro])
        @coluna_selecionada = Coluna.find_by_id(params[:coluna_selecionada])
        @quadro.coluna_id = @coluna_selecionada.id
        @quadro.status_id = @coluna_selecionada.status.id
        @quadro.baixado_dia = Time.now if @coluna_selecionada.status.finalizador
        if @quadro.save
        else
            if @quadro.errors.count == 1 && @quadro.errors.inspect.include?("attribute=usuario")
                @quadro.save(validate: false)
            end
        end
        carrega_quadros()
    end

    def adicionar_quadro
        @coluna = Coluna.find_by_id(params[:coluna])
        @quadro = Quadro.new
        @sprint = Sprint.find_by_id(params[:sprint])
    end

    def lista_prioridades
        @sprint = Sprint.find_by_id(params[:sprint_id])
        @quadros = @sprint.quadros.joins(:status).where('status.finalizador = false AND status.lista = true AND status.lista = true').order('rank DESC, status.rank ASC')
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

    def assumir_tarefa
        @quadro = Quadro.find_by_id(params[:quadro_id])
        @quadro.update(usuario_id: params[:usuario_id])
        @projeto = Projeto.find_by_id(params[:projeto])
        @colunas = @projeto.colunas
        @sprint = Sprint.find_by_id(params[:sprint])
        carrega_quadros()
    end

    def deixar_tarefa
        @quadro = Quadro.find_by_id(params[:quadro_id])
        @quadro.usuario_id = nil
        @quadro.save(validate: false)
        @projeto = Projeto.find_by_id(params[:projeto])
        @colunas = @projeto.colunas
        @sprint = Sprint.find_by_id(params[:sprint])
        carrega_quadros()
    end

    def carrega_quadros
        @colunas_ids = @projeto.colunas.pluck(:id)
        @hash_quadros = {}
        @colunas_ids.each do |col|
            @hash_quadros[col] = {}
            @hash_quadros[col] = @colunas.find_by_id(col).quadros.where(sprint_id: @sprint.id)
        end
    end

    def next_prioridade
        @sprint = Sprint.find_by_id(params[:sprint_id])
        @projeto = @sprint.projeto
        @colunas = @projeto.colunas
        @quadros_antigos = @sprint.quadros.joins(:status).where('status.lista = false AND usuario_id = (?)', @usuario_logado.id)
        @quadros_antigos.each do |quad|
            @proximo_status_temp = @projeto.status.where('rank > (?)', quad.status.rank).order('rank').first    
            @proxima_coluna_temp = Coluna.where(status_id: @proximo_status_temp.id).first
            quad.update(usuario_id: @usuario_logado.id, status_id: @proximo_status_temp.id, coluna_id: @proxima_coluna_temp.id)
        end
        @quadro = @sprint.quadros.joins(:status).where('status.finalizador = false AND status.lista = true').order('rank DESC, status.rank ASC').first
        @proximo_status = @projeto.status.where('rank > (?)', @quadro.status.rank).order('rank').first
        @proxima_coluna = Coluna.where(status_id: @proximo_status.id).first
        @quadro.update(usuario_id: @usuario_logado.id, status_id: @proximo_status.id, coluna_id: @proxima_coluna.id)
        carrega_quadros()
    end

end