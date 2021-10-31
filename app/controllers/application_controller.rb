class ApplicationController < ActionController::Base

    before_action :usuario_logado, except: [:login, :logar]

    def usuario_logado
        @usuario_logado = Usuario.find_by_id(cookies[:id])
    end

    def sair
        cookies.delete :id
        redirect_to home_index_path
    end

end
