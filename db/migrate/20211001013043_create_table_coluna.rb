class CreateTableColuna < ActiveRecord::Migration[6.1]
  def change
    create_table :colunas do |t|
      t.string   :nome
      t.integer  :posicao
      t.integer  :projeto_id
      t.integer  :empresa_id
      t.timestamps
    end
  end
end