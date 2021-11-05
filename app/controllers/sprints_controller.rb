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

end