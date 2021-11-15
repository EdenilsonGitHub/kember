class CreateTablePerfil < ActiveRecord::Migration[6.1]
  def change
    create_table :perfils do |t|
      t.string   :nome
      t.string   :descricao
      t.integer  :empresa_id
      t.timestamps
    end
  end
end
