class PerfilFuncionalidade < ActiveRecord::Base
    self.table_name = 'perfil_funcionalidades'

    belongs_to :perfil
    belongs_to :funcionalidade

end 