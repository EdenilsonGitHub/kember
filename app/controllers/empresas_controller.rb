class EmpresasController < ApplicationController

    def new
        @empresa = Empresa.new
    end

    def create
        @empresa = Empresa.new(params.require(:empresa).permit(:nome, :nome_fantasia, :sigla, :cnpj, :telefone, :email, :logo, :ativo))
        if @empresa.save
            @usuario_empresa = UsuarioEmpresa.new
            @usuario_empresa.usuario_id = @usuario_logado.id
            @usuario_empresa.empresa_id = @empresa.id
            @usuario_empresa.save
            redirect_to empresas_path
        else
            render action: 'new'
        end
    end

    def index
        @empresas = Empresa.where(id: UsuarioEmpresa.where(usuario_id: @usuario_logado.id).pluck(:empresa_id))
    end
    
    def sair_empresa
        UsuarioEmpresa.where(usuario_id: @usuario_logado.id, empresa_id: params[:empresa_id]).first.destroy
        @empresas = Empresa.where(id: UsuarioEmpresa.where(usuario_id: @usuario_logado.id).pluck(:empresa_id))
    end

end