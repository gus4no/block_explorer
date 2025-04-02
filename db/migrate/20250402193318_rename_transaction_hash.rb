class RenameTransactionHash < ActiveRecord::Migration[8.0]
  def change
    rename_column :transactions, :hash, :tx_hash
  end
end
