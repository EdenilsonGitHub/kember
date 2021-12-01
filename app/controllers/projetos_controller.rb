class ProjetosController < ApplicationController

    def index
        unless @usuario_logado
            redirect_to home_index_path 
            return
        end
        @projetos = Projeto.where(id: UsuarioProjeto.where(usuario_id: @usuario_logado.id).pluck(:projeto_id))
    end

    def new
        @projeto = Projeto.new
    end

    def edit
        @projeto = Projeto.find_by_id(params[:id])
    end

    def create
        @projeto = Projeto.new(params.require(:projeto).permit(:nome, :sigla, :descricao, :email, :inicio_projeto, :fim_projeto, :usuario_id, :empresa_id))
        if @projeto.save
            @usuario_projeto = UsuarioProjeto.new(usuario_id: params[:usuario_id], projeto_id: @projeto.id)
            @usuario_projeto.save
            redirect_to projetos_path
        else
            render action: 'new'
        end
    end

    def update
        @projeto = Projeto.find_by_id(params[:id])
        if @projeto.update(params.require(:projeto).permit(:nome, :sigla, :descricao, :email, :inicio_projeto, :fim_projeto, :usuario_id, :empresa_id))
            @sprints = @projeto.sprints
            render 'show'
        else
            render 'edit'
        end
    end

    def destroy
        Projeto.find_by_id(params[:id]).destroy
        redirect_to projetos_path
    end

    def show
        @projeto = Projeto.find_by_id(params[:id])
        @sprints = @projeto.sprints
    end

    def backlog
        @projeto = Projeto.find_by_id(params[:projeto_id])
        @quadros = Quadro.where(sprint_id: nil).where(coluna_id: @projeto.colunas.pluck(:id))
    end

end