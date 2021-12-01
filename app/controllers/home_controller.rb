class HomeController < ApplicationController

    def index
        @aba_selecionada = "inicio"
    end

    def gerenciamento
        @aba_selecionada = "projetos"
    end

    def em_breve
        @aba_selecionada = params[:selecionada] 
    end

end