class CreateTableUsuarioEmpresa < ActiveRecord::Migration[6.1]
  def change
    create_table :usuarios_empresas do |t|
      t.integer  :usuario_id
      t.integer  :empresa_id
      t.timestamps
    end
  end
end