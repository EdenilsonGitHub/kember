class CreateTableUsuarioEmpresa < ActiveRecord::Migration[6.1]
  def change
    add_column :usuarios, :usuario_empresa_id, :integer
    add_column :empresas, :usuario_empresa_id, :integer
  end
end
