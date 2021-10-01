class CreateTableProjeto < ActiveRecord::Migration[6.1]
  def change
    create_table :projetos do |t|
      t.string   :nome
      t.text     :descricao
      t.datetime :inicio_projeto
      t.datetime :fim_projeto
      t.integer  :empresa_id
      t.timestamps
    end
  end
end
