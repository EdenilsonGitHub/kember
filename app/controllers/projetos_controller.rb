class ProjetosController < ApplicationController

    def index
        @projetos = Projeto.all
    end

    def show
        @projeto = Projeto.find_by_id(params[:id])
        @sprints = @projeto.sprints
    end

    def backlog
        @projeto = Projeto.find_by_id(params[:projeto_id])
        @quadros = Quadro.where(sprint_id: nil).where(coluna_id: @projeto.colunas.pluck(:id))
    end

end