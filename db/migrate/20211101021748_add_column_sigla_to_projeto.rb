class AddColumnSiglaToProjeto < ActiveRecord::Migration[6.1]
  def change
    add_column :projetos, :sigla, :string
  end
end
