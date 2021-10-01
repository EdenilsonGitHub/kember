class AddColumnAuxiliarUsuarioProjeto < ActiveRecord::Migration[6.1]
  def change
    add_column :usuarios, :usuario_projeto_id, :integer
    add_column :projetos, :usuario_projeto_id, :integer
  end
end