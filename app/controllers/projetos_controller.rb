class ProjetosController < ApplicationController

    def index
        @projetos = Projeto.all
        @aba_selecionada == "projeto"
    end

    def show
        @projeto = Projeto.find_by_id(params[:id])
        @sprints = @projeto.sprints
        @aba_selecionada == "projeto"
    end

    def backlog
        @projeto = Projeto.find_by_id(params[:projeto_id])
        @quadros = Quadro.where(sprint_id: nil).where(coluna_id: @projeto.colunas.pluck(:id))
        @aba_selecionada == "projeto"
    end

end