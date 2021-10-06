class UsuarioProjeto < ActiveRecord::Base
    self.table_name = 'usuarios_projetos'

    belongs_to :usuario
    belongs_to :projeto

end