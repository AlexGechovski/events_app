class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :Events, :description, :description
  end
end
