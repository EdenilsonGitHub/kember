class StatusesController < ApplicationController

    def index
        @projeto = Projeto.find_by_id(params[:projeto_id])
        @status = @projeto.status.order('rank ASC')
    end

    def new
        @status = Status.new
    end

    def create
        @status = Status.new(params.require(:status).permit(:nome, :cor_fundo, :cor_fonte, :rank, :finalizador, :lista, :projeto_id, :empresa_id))
        if @status.save
            redirect_to statuses_path(projeto_id: @status.projeto.id)
        else
            render action: 'new'
        end
    end

end