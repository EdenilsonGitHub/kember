class CreateTablePerfilFuncionalidade < ActiveRecord::Migration[6.1]
  def change
    create_table :perfil_funcionalidades do |t|
      t.integer  :perfil_id
      t.integer  :funcionalidade_id
      t.timestamps
    end
  end
end
