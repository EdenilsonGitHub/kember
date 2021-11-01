class AddColumnSprintAtualToSprint < ActiveRecord::Migration[6.1]
  def change
    add_column :sprints, :sprint_atual, :boolean
  end
end
