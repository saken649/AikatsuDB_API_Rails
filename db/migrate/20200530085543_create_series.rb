class CreateSeries < ActiveRecord::Migration[6.0]
  def change
    create_table :series, id: false do |t|
      t.column :id, 'int(11) PRIMARY KEY'
      t.string :title, limit: 64, null: false
      t.string :sub_title, limit: 64
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
