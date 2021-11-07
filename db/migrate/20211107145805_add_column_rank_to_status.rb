class AddColumnRankToStatus < ActiveRecord::Migration[6.1]
  def change
    add_column :status, :rank, :integer, default: 1
  end
end
