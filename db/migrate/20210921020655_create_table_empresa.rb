class CreateTableEmpresa < ActiveRecord::Migration[6.1]
  def change
    create_table :empresas do |t|
      t.string  :nome
      t.string  :nome_fantasia
      t.string  :sigla
      t.string  :cnpj
      t.string  :telefone
      t.string  :email
      t.boolean :ativo
      t.timestamps
    end
    add_attachment :empresas, :logo
  end
end
