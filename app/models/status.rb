class Status < ActiveRecord::Base
    self.table_name = 'status'

    validates :nome, presence: true
    validates :nome, length: { minimum: 1, message: 'é muito curto (mínimo: 1 caracteres)' }
    validates :nome, length: { maximum: 30, message: 'é muito longo (máximo: 30 caracteres)' }
    
    belongs_to :empresa

end