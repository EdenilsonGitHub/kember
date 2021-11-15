class CreateTableFuncionalidade < ActiveRecord::Migration[6.1]
  def change
    create_table :funcionalidades do |t|
      t.string   :nome
      t.integer  :sys_id
      t.boolean  :incluir
      t.boolean  :alterar
      t.boolean  :excluir
      t.integer  :empresa_id
      t.timestamps
    end
  end
end
