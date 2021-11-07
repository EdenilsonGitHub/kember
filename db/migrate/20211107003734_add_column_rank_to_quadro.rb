class AddColumnRankToQuadro < ActiveRecord::Migration[6.1]
  def change
    add_column :quadros, :rank, :integer, default: 3
  end
end
