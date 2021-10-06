class AddColumnProjetoIdToStatus < ActiveRecord::Migration[6.1]
    def change
        add_column :status, :projeto_id, :integer
    end
end