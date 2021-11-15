class Perfil < ActiveRecord::Base
    self.table_name = 'perfils'

    validates :nome, :descricao, presence: true
    validates :nome, :descricao, length: { maximum: 255, message: 'é muito longo (máximo: 255 caracteres)' }
    
    belongs_to :empresa

end 