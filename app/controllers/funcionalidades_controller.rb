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

end