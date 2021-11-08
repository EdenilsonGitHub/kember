class AddColumnStatusDeListaToStatus < ActiveRecord::Migration[6.1]
  def change
    add_column :status, :lista, :boolean, default: false
  end
end
