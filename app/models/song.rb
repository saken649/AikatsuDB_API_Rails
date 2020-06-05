class Song < ApplicationRecord
  has_many :song_singers
  has_many :singers, through: :song_singers

  has_many :song_characters
  has_many :characters, through: :song_characters

  has_many :song_creators
  has_many :creators, through: :song_creators

  has_many :song_albums
  has_many :albums, through: :song_albums

  has_many :aitubes
  belongs_to :series

  has_many :songs_child, class_name: 'Song', foreign_key: 'parent_song_id', dependent: :destroy
  belongs_to :songs_parent, class_name: 'Song', foreign_key: 'parent_song_id', optional: true

  def self.list(song_id)
    sql = <<SQL
SELECT
  vss.id AS song_id,
  vss.parent_song_id,
  vss.title,
  vss.sub_title,
  s2.id AS singer_id,
  s2.display_name,
  g.name AS group_name,
  ss.display_order,
  ss.group_displayable,
  ss.delimiter_to_next,
  vss.image_path
FROM v_sorted_songs AS vss
LEFT OUTER JOIN v_sorted_songs AS vss2
  ON vss.id = vss2.id
  AND vss.sold_date > vss2.sold_date
INNER JOIN song_singers AS ss ON vss.id = ss.song_id
INNER JOIN singers AS s2 ON ss.singer_id = s2.id
INNER JOIN `groups` AS g ON s2.group_id = g.id
WHERE
SQL
    if song_id.nil?
      sql += "  vss2.sold_date IS NULL\n"
    else
      sql += "  (vss.id = :song_id OR vss.parent_song_id = :song_id) AND vss2.sold_date IS NULL\n"
    end
    sql += <<SQL
ORDER BY
  vss.sold_date,
  vss.disc_number,
  vss.track_number,
  ss.display_order
SQL
    # TODO: View 導入でクエリがシンプルになった→Active Record で書けるのでは？いつか試す
    if song_id.nil?
      results = Song.find_by_sql(sql)
    else
      results = Song.find_by_sql([sql, {song_id: song_id}])
    end
    results
  end
　
  def self.song_with_related_records_by_id(song_id)
    # FIXME: バージョン違い対応が出来てない！
    Song.includes([
                    :songs_child,
                    :song_singers,
                    :singers,
                    :song_creators,
                    :creators,
                    :song_albums,
                    :albums,
                    :aitubes,
                    :series,
                    singers: :group,
                    albums: :album_tracks,
                    creators: :production
                  ])
      .where(songs: {id: song_id})
      .order('song_singers.display_order ASC')
      .order('song_creators.display_order ASC')
      .order('albums.sold_date ASC')
      .order('aitubes.order ASC')
      .to_a
      .first
  end
end