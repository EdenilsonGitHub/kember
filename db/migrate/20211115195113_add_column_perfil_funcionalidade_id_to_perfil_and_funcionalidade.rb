class AddColumnPerfilFuncionalidadeIdToPerfilAndFuncionalidade < ActiveRecord::Migration[6.1]
  def change
    add_column :perfils, :perfil_funcionalidade_id, :integer
    add_column :funcionalidades, :perfil_funcionalidade_id, :integer
  end
end
