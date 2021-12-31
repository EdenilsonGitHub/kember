class UsuarioEmpresa < ActiveRecord::Base
    self.table_name = 'usuarios_empresas'

    belongs_to :usuario, optional: true
    belongs_to :empresa, optional: true

end 