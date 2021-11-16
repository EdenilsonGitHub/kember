class EmpresasController < ApplicationController

    def new
        @empresa = Empresa.new
    end

    def create
        @empresa = Empresa.new(params.require(:empresa).permit(:nome, :nome_fantasia, :sigla, :cnpj, :telefone, :email, :logo, :ativo))
        if @empresa.save
            redirect_to empresas_path
        else
            render action: 'new'
        end
    end

end