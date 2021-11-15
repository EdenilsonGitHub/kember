class AddColumnPerfilIdToUsuario < ActiveRecord::Migration[6.1]
  def change
    add_column :usuarios, :perfil_id, :integer
  end
end
