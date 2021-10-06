class Quadro < ActiveRecord::Base
    self.table_name = 'quadros'

    validates :nome, :descricao, presence: true
    validates :nome, length: { minimum: 1, message: 'é muito curto (mínimo: 5 caracteres)' }
    validates :nome, length: { maximum: 255, message: 'é muito longo (máximo: 255 caracteres)' }
    validates :descricao, length: { minimum: 10, message: 'é muito curto (mínimo: 10 caracteres)' }
    validates :descricao, length: { maximum: 1000, message: 'é muito longo (máximo: 1000 caracteres)' }

    belongs_to :status
    belongs_to :coluna
    belongs_to :usuario

end