class AddColumnBaixadaNoDiaToQuadro < ActiveRecord::Migration[6.1]
  def change
    add_column :quadros, :baixada_dia, :datetime
  end
end
