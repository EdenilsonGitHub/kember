class AddColumnSprintIdToQuadro < ActiveRecord::Migration[6.1]
  def change
    add_column :quadros, :sprint_id, :integer
  end
end
