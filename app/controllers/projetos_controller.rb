class ProjetosController < ApplicationController

    def index
        @projetos = Projeto.all
    end

    def show
        @projeto = Projeto.find_by_id(params[:id])
    end

end