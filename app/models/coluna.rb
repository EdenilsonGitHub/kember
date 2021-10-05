class Coluna < ActiveRecord::Base
    self.table_name = 'colunas'

    validates :nome, :posicao, presence: true
    validates :nome, length: { minimum: 1, message: 'é muito curto (mínimo: 1 caracteres)' }
    validates :nome, length: { maximum: 20, message: 'é muito longo (máximo: 20 caracteres)' }
    
    belongs_to :empresa
    belongs_to :projeto

    has_many :quadros

end