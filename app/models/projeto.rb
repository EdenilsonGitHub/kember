class Projeto < ActiveRecord::Base
    self.table_name = 'projetos'

    validates :nome, :descricao, :inicio_projeto, :fim_projeto, presence: true
    validates :nome, length: { minimum: 1, message: 'é muito curto (mínimo: 1 caracteres)' }
    validates :descricao, length: { minimum: 10, message: 'é muito curto (mínimo: 10 caracteres)' }
    validates :nome, length: { maximum: 255, message: 'é muito longo (máximo: 255 caracteres)' }
    
    belongs_to :empresa

    has_many :sprints
    has_many :status
    has_many :colunas

end 