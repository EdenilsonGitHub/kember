class CreateTableQuadro < ActiveRecord::Migration[6.1]
  def change
    create_table :quadros do |t|
      t.string   :nome
      t.text     :descricao
      t.boolean  :burndown
      t.integer  :pontuacao
      t.integer  :usuario_id
      t.integer  :coluna_id
      t.integer  :status_id
      t.timestamps
    end
  end
end
