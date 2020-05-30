class CreateProductions < ActiveRecord::Migration[6.0]
  def change
    create_table :productions, id: :string, limit: 32 do |t|
      t.string :name, limit: 32, null: false
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
