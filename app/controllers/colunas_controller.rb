class ColunasController < ApplicationController

    def new
        @coluna = Coluna.new
        @status = Status.all
    end

    def create
        @status = Status.all
        @coluna = Coluna.new(params.require(:coluna).permit(:nome, :posicao, :status_id, :projeto_id, :empresa_id))
        if @coluna.save(validate: false)
            redirect_to colunas_path
        else
            render action: 'new'
        end
    end

end