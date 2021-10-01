class CreateTableUsuarioProjeto < ActiveRecord::Migration[6.1]
  def change
    create_table :usuarios_projetos do |t|
      t.integer  :usuario_id
      t.integer  :projeto_id
      t.timestamps
    end
  end
end