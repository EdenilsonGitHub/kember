class ApplicationController < ActionController::Base

    before_action :usuario_logado, except: [:login, :logar]
    before_action :aba_selecionada

    def aba_selecionada
        @aba_selecionada = "inicio" if params[:controller] == "home"
        @aba_selecionada ||= "projetos" if params[:controller] == "projetos"
        @aba_selecionada ||= "projetos" if params[:controller] == "colunas"
        @aba_selecionada ||= "projetos" if params[:controller] == "empresas"
        @aba_selecionada ||= "projetos" if params[:controller] == "funcionalidades"
        @aba_selecionada ||= "projetos" if params[:controller] == "perfils"
        @aba_selecionada ||= "projetos" if params[:controller] == "quadros"
        @aba_selecionada ||= "projetos" if params[:controller] == "sprints"
        @aba_selecionada ||= "projetos" if params[:controller] == "statuses"
    end
    
    def usuario_logado
        @usuario_logado = Usuario.find_by_id(cookies[:id])
    end

    def sair
        cookies.delete :id
        redirect_to home_index_path
    end

end
