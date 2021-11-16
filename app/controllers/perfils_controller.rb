class PerfilsController < ApplicationController

    def new
        @perfil = Perfil.new
    end

    def show
        @perfil = Perfil.find_by_id(params[:id])
        @funcionalidades = Funcionalidade.where(id: PerfilFuncionalidade.where(perfil_id: @perfil.id).pluck(:funcionalidade_id)).order('sys_id ASC')
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

    def adicionar_funcionalidade_perfil
        pf = PerfilFuncionalidade.new(funcionalidade_id: params[:funcionalidade], perfil_id: params[:perfil_id])
        pf.save
        redirect_to perfil_path(id: params[:perfil_id])
    end

end