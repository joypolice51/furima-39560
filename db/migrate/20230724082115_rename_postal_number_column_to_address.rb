class RenamePostalNumberColumnToAddress < ActiveRecord::Migration[7.0]
  def change
    rename_column :addresses, :postal_number, :postal_code
  end
end
