class PerfilsController < ApplicationController

    def index
        @empresa = Empresa.first
        @perfis = Perfil.order('nome ASC')
    end

    def new
        @perfil = Perfil.new
    end

    def edit
        @perfil = Perfil.find_by_id(params[:id])
    end

    def destroy
        Perfil.find_by_id(params[:id]).destroy
        @empresa = Empresa.find_by_id(params[:empresa_id])
        @perfis = @empresa.perfils.order('nome ASC')
    end

    def update
        @perfil = Perfil.find_by_id(params[:id])
        @empresa = @perfil.empresa
        @perfis = @empresa.perfils.order('nome ASC')
        if @perfil.update(params.require(:perfil).permit(:nome, :descricao, :empresa_id))
            render 'index'
        else
            render 'edit'
        end
    end

    def show
        @perfil = Perfil.find_by_id(params[:id])
        @funcionalidades = Funcionalidade.where(id: PerfilFuncionalidade.where(perfil_id: @perfil.id).pluck(:funcionalidade_id)).order('sys_id ASC')
        @usuarios = Usuario.where('perfil_id = (?)', @perfil.id)
    end

    def create
        @perfil = Perfil.new(params.require(:perfil).permit(:nome, :descricao, :empresa_id))
        if @perfil.save
            redirect_to perfils_path(empresa_id: 1)
        else
            render action: 'new'
        end
    end

    def adicionar_funcionalidade
        @perfil = Perfil.find_by_id(params[:perfil_id])
        @empresa = @perfil.empresa
        @funcionalidades_perfil = Funcionalidade.where(id: PerfilFuncionalidade.where(perfil_id: @perfil.id).pluck(:funcionalidade_id)).order('sys_id ASC')
        @funcionalidades = @empresa.funcionalidades.reject{|func| func.in?(@funcionalidades_perfil)}
    end

    def excluir_funcionalidade
        @funcionalidade = Funcionalidade.find_by_id(params[:funcionalidade_id])
        @perfil = Perfil.find_by_id(params[:perfil_id])
        PerfilFuncionalidade.where(perfil_id: @perfil.id, funcionalidade_id: @funcionalidade.id).first.destroy
        @funcionalidades = Funcionalidade.where(id: PerfilFuncionalidade.where(perfil_id: @perfil.id).pluck(:funcionalidade_id)).order('sys_id ASC')    
    end

    def adicionar_funcionalidade_perfil
        pf = PerfilFuncionalidade.new(funcionalidade_id: params[:funcionalidade], perfil_id: params[:perfil_id])
        pf.save
        redirect_to perfil_path(id: params[:perfil_id])
    end

    def adicionar_usuario_p
        @perfil = Perfil.find_by_id(params[:perfil_id])
        @empresa = @perfil.empresa
        @usuarios = Usuario.where('perfil_id <> (?) OR perfil_id IS NULL', @perfil.id)
    end

    def excluir_usuario
        # @funcionalidade = Funcionalidade.find_by_id(params[:funcionalidade_id])
        # @perfil = Perfil.find_by_id(params[:perfil_id])
        # PerfilFuncionalidade.where(perfil_id: @perfil.id, funcionalidade_id: @funcionalidade.id).first.destroy
        # @funcionalidades = Funcionalidade.where(id: PerfilFuncionalidade.where(perfil_id: @perfil.id).pluck(:funcionalidade_id)).order('sys_id ASC')    
    end

    def adicionar_usuario_perfil
        @usuario = Usuario.find_by_id(params[:usuario])
        @usuario.perfil_id = params[:perfil_id]
        @usuario.save(validate: false)
        redirect_to perfil_path(id: params[:perfil_id])
    end

end