class QuadrosController < ApplicationController

    def create
        @quadro = Quadro.new(params.require(:quadro).permit(:nome, :descricao, :burndown, :pontuacao, :rank, :usuario_id, :status_id, :coluna_id, :sprint_id))
        @projeto = Projeto.find_by_id(params[:projeto_id])
        @colunas = @projeto.colunas
        @sprint = Sprint.find_by_id(params[:sprint_id])
        @colunas_ids = @projeto.colunas.pluck(:id)
        @hash_quadros = {}
        @colunas_ids.each do |col|
            @hash_quadros[col] = {}
            @hash_quadros[col] = @colunas.find_by_id(col).quadros.where(sprint_id: @sprint.id)
        end
        @quadro.usuario_id = params[:usuario_id] if @quadro.coluna.status.finalizador
        if @quadro.save
        else
            if @quadro.errors.count == 1 && @quadro.errors.inspect.include?("attribute=usuario")
                @quadro.save(validate: false)
            else
                render action: 'new'
            end
        end
    end

end