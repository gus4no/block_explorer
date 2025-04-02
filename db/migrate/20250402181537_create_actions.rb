class CreateActions < ActiveRecord::Migration[8.0]
  def change
    create_table :actions do |t|
      t.references :transaction, null: false, foreign_key: true

      # Regular columns for frequently queried fields
      # decimal with big precision for large numbers
      t.decimal :deposit, precision: 30, scale: 0, default: 0, null: false
      t.string :action_type, null: false

      # Jsonb column for dynamic or optional fields
      t.jsonb :data, default: {}

      t.timestamps
    end

    # Adding an index to speed up queries involving the `data` column if necessary
    # For example, querying method name in the jsonb field:
    add_index :actions, :data, using: :gin
  end
end
