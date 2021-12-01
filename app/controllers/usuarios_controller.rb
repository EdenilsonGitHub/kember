class UsuariosController < ApplicationController

    def new
        @aba_selecionada = "inicio"
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
            @aba_selecionada = "projetos"
            redirect_to projetos_path
        else
            @aba_selecionada = "inicio"
            render 'login'
        end
    end
    
    def create
        @usuario = Usuario.new(params.require(:usuario).permit(:nome, :login, :senha, :email, :foto, :admin, :senha_confirmation))
        if @usuario.save(validate: false)
            if @usuario_logado
                @aba_selecionada = "projetos"
                redirect_to projetos_path
            else
                @aba_selecionada = "inicio"
                redirect_to login_path
            end
        else
            @aba_selecionada = "inicio"
            render action: 'new'
        end
    end

end