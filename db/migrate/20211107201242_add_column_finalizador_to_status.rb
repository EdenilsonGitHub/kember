class AddColumnFinalizadorToStatus < ActiveRecord::Migration[6.1]
  def change
    add_column :status, :finalizador, :boolean, default: false
  end
end
