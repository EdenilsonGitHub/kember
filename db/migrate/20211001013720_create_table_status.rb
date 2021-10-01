class CreateTableStatus < ActiveRecord::Migration[6.1]
  def change
    create_table :status do |t|
      t.string   :nome
      t.string   :cor_fundo
      t.string   :cor_fonte
      t.integer  :empresa_id
      t.timestamps
    end
  end
end