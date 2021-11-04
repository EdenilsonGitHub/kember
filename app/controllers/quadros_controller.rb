class QuadrosController < ApplicationController

    def create
        @quadro = Quadro.new(params.require(:quadro).permit(:nome, :descricao, :burndown, :pontuacao, :usuario_id, :status_id, :coluna_id))
        @projeto = Projeto.find_by_id(params[:projeto_id])
        @colunas = @projeto.colunas
        @sprint = Sprint.find_by_id(params[:sprint_id])
        if @quadro.save
        else
            render action: 'new'
        end
    end

end