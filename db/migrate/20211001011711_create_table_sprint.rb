class CreateTableSprint < ActiveRecord::Migration[6.1]
  def change
    create_table :sprints do |t|
      t.string   :nome
      t.text     :descricao
      t.datetime :inicio_sprint
      t.datetime :fim_sprint
      t.boolean  :burndown
      t.integer  :pontuacao_total
      t.integer  :projeto_id
      t.timestamps
    end
  end
end