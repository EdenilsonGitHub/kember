class Sprint < ActiveRecord::Base
    self.table_name = 'sprints'

    validates :nome, :descricao, :inicio_sprint, :fim_sprint, presence: true
    validates :nome, length: { minimum: 5, message: 'é muito curto (mínimo: 5 caracteres)' }
    validates :descricao, length: { minimum: 10, message: 'é muito curto (mínimo: 10 caracteres)' }
    validates :nome, length: { maximum: 255, message: 'é muito longo (máximo: 255 caracteres)' }
    
    belongs_to :projeto

    has_many :quadros

end 