class ChangeApiTimestampsName < ActiveRecord::Migration[8.0]
  def change
    change_table :transactions do |t|
      t.rename :api_created_at, :external_created_at
      t.rename :api_updated_at, :external_updated_at
    end
  end
end
