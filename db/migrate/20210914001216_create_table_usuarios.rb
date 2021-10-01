class CreateTableUsuarios < ActiveRecord::Migration[6.1]
  def change
    create_table :usuarios do |t|
      t.string  :nome
      t.string  :login
      t.string  :senha
      t.string  :email
      t.boolean :admin
      t.timestamps
    end
    add_attachment :usuarios, :foto
  end
end
