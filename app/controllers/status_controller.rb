class StatusController < ApplicationController

    def show
        @projeto = Projeto.find_by_id(params[:projeto_id])
        @status = @projeto.status
    end

end