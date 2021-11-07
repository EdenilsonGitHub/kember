class AddColumnStatusIdOnColuna < ActiveRecord::Migration[6.1]
  def change
    add_column :colunas, :status_id, :integer
  end
end
