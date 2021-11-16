class AddColumnDescricaoToFuncionalidade < ActiveRecord::Migration[6.1]
  def change
    add_column :funcionalidades, :descricao, :text
  end
end
