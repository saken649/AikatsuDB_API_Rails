class CreateVSingers < ActiveRecord::Migration[6.0]
  # TODO: 作ったけど差し替えが大変なので一旦放置
  def up
    execute <<-SQL
DROP VIEW IF EXISTS v_sorted_songs
    SQL

    execute <<-SQL
CREATE OR REPLACE VIEW v_singers AS
SELECT
  s.id,
  s.parent_singer_id,
  COALESCE(s2.name_family, s.name_family) AS name_family,
  COALESCE(s2.name_first, s.name_first) AS name_first,
  COALESCE(s2.name_family_kana, s.name_family_kana) AS name_family_kana,
  COALESCE(s2.name_first_kana, s.name_first_kana) AS name_first_kana,
  s.display_name,
  s.group_id,
  s.has_children,
  s.is_current,
  s.`order`,
  s.created_at,
  s.updated_at,
  s.deleted_at
FROM singers AS s
LEFT OUTER JOIN singers AS s2
  ON s.parent_singer_id = s2.id
    SQL
  end

  def down
    execute <<-SQL
DROP VIEW IF EXISTS v_singers
    SQL
  end
end
