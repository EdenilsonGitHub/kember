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

    def index
        @projeto = Projeto.find_by_id(params[:projeto_id])
        @colunas = @projeto.colunas.order('posicao ASC')
    end

    def destroy
        @coluna = Coluna.find_by_id(params[:id])
        @coluna.destroy
        @projeto = Projeto.find_by_id(params[:projeto_id])
        @colunas = @projeto.colunas.order('posicao ASC')
    end

    def edit
        @coluna = Coluna.find_by_id(params[:id])
        @status = Status.all
    end

    def update
        @coluna = Coluna.find_by_id(params[:id])
        @projeto = Projeto.find_by_id(params[:coluna][:projeto_id])
        @colunas = @projeto.colunas.order('posicao ASC')
        if @coluna.update(params.require(:coluna).permit(:nome, :posicao, :status_id, :projeto_id, :empresa_id))
            render 'index'
        else
            render 'edit'
        end
    end

end