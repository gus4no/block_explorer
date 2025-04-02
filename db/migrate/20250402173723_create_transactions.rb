class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.bigint :external_id, null: false, index: { unique: true }
      t.datetime :time, null: false
      t.integer :height, null: false
      t.string :hash, null: false, index: { unique: true }
      t.string :block_hash, null: false
      t.string :sender, null: false
      t.string :receiver, null: false
      t.bigint :gas_burnt, null: false
      t.integer :actions_count, default: 0
      t.boolean :success, null: false, default: true
      t.datetime :api_created_at, null: false
      t.datetime :api_updated_at, null: false

      t.timestamps
    end
  end
end

