class Funcionalidade < ActiveRecord::Base
    self.table_name = 'funcionalidades'

    validates :sys_id, uniqueness: true
    validates :nome, :sys_id, presence: true
    validates :nome, length: { maximum: 255, message: 'é muito longo (máximo: 255 caracteres)' }
    
    belongs_to :empresa

    has_many :perfil_funcionalidades

end 