class Quadro < ActiveRecord::Base
    self.table_name = 'quadros'

    validates :nome, presence: true
    validates :nome, length: { minimum: 1, message: 'é muito curto (mínimo: 1 caracteres)' }
    validates :nome, length: { maximum: 80, message: 'é muito longo (máximo: 80 caracteres)' }
    validates :descricao, length: { maximum: 1000, message: 'é muito longo (máximo: 1000 caracteres)' }
    validates :rank, length: { maximum: 5, message: 'é muito longo (máximo: 5 caracteres)' }
    validates :rank, length: { minimum: 1, message: 'é muito curto (mínimo: 1 caractere)' }
    validates :usuario_id, numericality: { only_integer: true, allow_nil: true }

    belongs_to :status
    belongs_to :coluna
    belongs_to :usuario
    belongs_to :sprint

end