class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums, id: :string, limit: 64 do |t|
      t.string :title, limit: 128, null: false
      t.string :sub_title, limit: 128
      t.datetime :sold_date, null: false
      t.string :image_path, limit: 128, null: false
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
