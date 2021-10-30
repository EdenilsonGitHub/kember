class ProjetosController < ApplicationController

    def index
        @projetos = Projeto.all
    end

end