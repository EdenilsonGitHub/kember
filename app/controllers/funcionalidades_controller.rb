class FuncionalidadesController < ApplicationController

    def new
        @funcionalidade = Funcionalidade.new
    end

    def create
        @funcionalidade = Funcionalidade.new(params.require(:funcionalidade).permit(:nome, :descricao, :sys_id, :incluir, :alterar, :excluir, :empresa_id))
        if @funcionalidade.save
            redirect_to funcionalidades_path(empresa_id: 1)
        else
            render action: 'new'
        end
    end

    def index
        @empresa = Empresa.find_by_id(params[:empresa_id])
        @funcionalidades = Funcionalidade.where(empresa_id: @empresa.id).order('sys_id ASC')
    end

    def destroy
        Funcionalidade.find_by_id(params[:id]).destroy
        @empresa = Empresa.find_by_id(params[:empresa_id])
        @funcionalidades = @empresa.funcionalidades.order('sys_id ASC')
    end

    def edit
        @funcionalidade = Funcionalidade.find_by_id(params[:id])
    end

    def update
        @funcionalidade = Funcionalidade.find_by_id(params[:id])
        @empresa = @funcionalidade.empresa
        @funcionalidades = @empresa.funcionalidades.order('sys_id ASC')
        if @funcionalidade.update(params.require(:funcionalidade).permit(:nome, :descricao, :sys_id, :incluir, :alterar, :excluir, :empresa_id))
            render 'index'
        else
            render 'edit'
        end
    end

end