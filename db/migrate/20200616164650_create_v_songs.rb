class CreateVSongs < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
DROP VIEW IF EXISTS v_sorted_songs
    SQL

    execute <<-SQL
CREATE OR REPLACE VIEW v_songs AS
SELECT
  s.id,
  s.parent_song_id,
  COALESCE(s2.title, s.title) AS title,
  COALESCE(s2.title_kana, s.title_kana) AS title_kana,
  s.sub_title,
  s.is_short,
  s.song_type,
  s.series_id,
  s.created_at,
  s.updated_at,
  s.deleted_at
FROM songs AS s
LEFT OUTER JOIN songs AS s2
  ON s.parent_song_id = s2.id
    SQL
  end

  def down
    execute <<-SQL
DROP VIEW IF EXISTS v_songs
    SQL
  end
end
