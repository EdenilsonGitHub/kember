class UsuariosController < ApplicationController

    def new
        @usuario = Usuario.new
    end

    def logar
        usuario = Usuario.find_by_login(params[:login])
        if usuario && usuario.validou(params[:senha])
            if params[:conectado]
                cookies.permanent[:id] = usuario.id.to_s
            else
                cookies[:id] = usuario.id.to_s
            end
            redirect_to projetos_path
        else
            render 'login'
        end
    end

    def create
        @usuario = Usuario.new(params.require(:usuario).permit(:nome, :login, :senha, :email, :foto, :admin, :senha_confirmation))
        if @usuario.save
            if @usuario_logado
                redirect_to projetos_path
            else
                redirect_to login_path
            end
        else
            render action: 'new'
        end
    end

end