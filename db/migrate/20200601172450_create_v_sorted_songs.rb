class CreateVSortedSongs < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
DROP VIEW IF EXISTS v_sorted_songs
    SQL

    execute <<-SQL
CREATE OR REPLACE VIEW v_sorted_songs AS
SELECT
  s.id,
  s.parent_song_id,
  COALESCE(s.title, (SELECT title FROM songs WHERE id = s.parent_song_id)) AS title,
  s.sub_title,
  a.sold_date,
  sa.disc_number,
  sa.track_number,
  a.image_path
FROM albums AS a
INNER JOIN song_albums AS sa ON a.id = sa.album_id
INNER JOIN songs AS s ON sa.song_id = s.id
ORDER BY
  a.sold_date,
  sa.disc_number,
  sa.track_number
    SQL
  end

  def down
    execute <<-SQL
DROP VIEW IF EXISTS v_sorted_songs
    SQL
  end
end
