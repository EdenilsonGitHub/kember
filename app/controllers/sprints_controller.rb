class SprintsController < ApplicationController

    def show
        @sprint = Sprint.find_by_id(params[:id])
        @projeto = @sprint.projeto
        @colunas = @projeto.colunas.order('posicao ASC')
        carrega_quadros()
        @usuarios = Usuario.where(id: UsuarioProjeto.where(projeto_id: @projeto.id).pluck(:usuario_id))
    end

    def edit
        @sprint = Sprint.find_by_id(params[:id])
        params[:projeto_id] = @sprint.projeto.id
    end

    def update
        @sprint = Sprint.find_by_id(params[:id])
        @projeto = @sprint.projeto
        @usuarios = @usuarios = Usuario.where(id: UsuarioProjeto.where(projeto_id: @projeto.id).pluck(:usuario_id))
        @colunas = @projeto.colunas.order('posicao ASC')
        carrega_quadros()
        if @sprint.update(params.require(:sprint).permit(:nome, :descricao, :inicio_sprint, :fim_sprint, :burndown, :sprint_atual, :projeto_id))
            render 'show'
        else
            render 'edit'
        end
    end

    def new
        @sprint = Sprint.new
    end

    def create
        if params[:sprint][:sprint_atual] == "1"
            @projeto = Projeto.find_by_id(params[:sprint][:projeto_id])
            @projeto.sprints.update_all(sprint_atual: false)
        end
        @sprint = Sprint.new(params.require(:sprint).permit(:nome, :descricao, :inicio_sprint, :fim_sprint, :burndown, :sprint_atual, :projeto_id))
        if @sprint.save
            redirect_to projeto_path(id: @sprint.projeto.id)
        else
            render action: 'new'
        end
    end

    def mover_tarefa
        @sprint = Sprint.find_by_id(params[:sprint])
        @projeto = Projeto.find_by_id(params[:projeto])
        @colunas = @projeto.colunas.order('posicao ASC')
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
        @quadro.baixada_dia = DateTime.now if @coluna_selecionada.status.finalizador
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
        @quadros = @sprint.quadros.joins(:status).where('(usuario_id <> :usuario_logado OR usuario_id IS NULL) AND status.finalizador = false AND status.lista = true', usuario_logado: @usuario_logado.id).order('status.rank DESC, rank DESC')
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
        @colunas = @projeto.colunas.order('posicao ASC')
        @sprint = Sprint.find_by_id(params[:sprint])
        carrega_quadros()
    end

    def deixar_tarefa
        @quadro = Quadro.find_by_id(params[:quadro_id])
        @quadro.usuario_id = nil
        @quadro.save(validate: false)
        @projeto = Projeto.find_by_id(params[:projeto])
        @colunas = @projeto.colunas.order('posicao ASC')
        @sprint = Sprint.find_by_id(params[:sprint])
        carrega_quadros()
    end

    def carrega_quadros
        @colunas_ids = @projeto.colunas.order('posicao ASC').pluck(:id)
        @hash_quadros = {}
        @colunas_ids.each do |col|
            @hash_quadros[col] = {}
            @hash_quadros[col] = @colunas.find_by_id(col).quadros.where(sprint_id: @sprint.id)
        end
    end

    def next_prioridade
        @sem_tarefas = false
        @sprint = Sprint.find_by_id(params[:sprint_id])
        @projeto = @sprint.projeto
        @colunas = @projeto.colunas.order('posicao ASC')
        @quadros_antigos = @sprint.quadros.joins(:status).where('status.lista = false AND usuario_id = (?)', @usuario_logado.id)
        @quadros_antigos.each do |quad|
            next if quad.status.finalizador
            @proximo_status_temp = @projeto.status.where('rank > (?)', quad.status.rank).order('rank').first    
            @proxima_coluna_temp = Coluna.where(status_id: @proximo_status_temp.id).first
            if @proximo_status_temp.finalizador
                quad.update(usuario_id: @usuario_logado.id, status_id: @proximo_status_temp.id, coluna_id: @proxima_coluna_temp.id, baixada_dia: Time.now)
            else
                quad.update(usuario_id: @usuario_logado.id, status_id: @proximo_status_temp.id, coluna_id: @proxima_coluna_temp.id)
            end
        end
        @quadro = @sprint.quadros.joins(:status).where('(usuario_id <> :usuario_logado OR usuario_id IS NULL) AND status.finalizador = false AND status.lista = true', usuario_logado: @usuario_logado.id).order('status.rank DESC, rank DESC').first
        @sem_tarefas = true unless @quadro
        unless @sem_tarefas
            @proximo_status = @projeto.status.where('rank > (?)', @quadro.status.rank).order('rank').first
            @proxima_coluna = Coluna.where(status_id: @proximo_status.id).first
            @quadro.update(usuario_id: @usuario_logado.id, status_id: @proximo_status.id, coluna_id: @proxima_coluna.id)
        end
        carrega_quadros()
    end

    def burndown
        @sprint = Sprint.find_by_id(params[:sprint_id])
        @quadros = @sprint.quadros.where(burndown: true)
        @ideal = @quadros.pluck(:pontuacao).inject(:+)
        @ideal_save = @quadros.pluck(:pontuacao).inject(:+)
        @real = @quadros.pluck(:pontuacao).inject(:+)
        @hash_ideal = []
        @dias_sprint = (@sprint.fim_sprint.to_date - @sprint.inicio_sprint.to_date).to_i
        @hash_dias_sprint = []
        @ideal_por_dia = @ideal / @dias_sprint
        @dias_sprint.times{
            @hash_ideal << @ideal
            @ideal = @ideal - @ideal_por_dia
        }
        @hash_real = []
        @dia = 0
        @pontuacao_dia_anterior = 0
        (@sprint.fim_sprint.to_date - @sprint.inicio_sprint.to_date).to_i.times{
            @dia_sprint = @sprint.inicio_sprint.to_date + @dia.days
            @pontuacao_dia = @quadros.where('baixada_dia IS NOT NULL AND date(baixada_dia) = (?)', @dia_sprint.to_date).pluck(:pontuacao).inject(:+)
            @hash_real << @real
            @real = @real - @pontuacao_dia.to_i
            @hash_dias_sprint << @dia_sprint.day             
            @dia += 1 
        }
    end

end