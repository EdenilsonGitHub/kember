class UsuarioEmpresa < ActiveRecord::Base
    self.table_name = 'usuarios_empresas'

    belongs_to :usuario
    belongs_to :empresa

end 