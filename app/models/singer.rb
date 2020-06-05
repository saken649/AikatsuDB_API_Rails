class Singer < ApplicationRecord
  has_many :song_singers
  has_many :songs, through: :song_singers

  has_many :singers_child, class_name: 'Singer', foreign_key: 'parent_singer_id', dependent: :destroy
  belongs_to :singers_parent, class_name: 'Singer', foreign_key: 'parent_singer_id', optional: true

  belongs_to :group, optional: true

  has_many :character_singers
  has_many :characters, through: :character_singers

  # 歌唱担当名前一覧
  # @return [Array<String>]
  def self.name_list
    sql = <<'SQL'
SELECT s.display_name FROM singers AS s
LEFT JOIN singers AS s2 ON s.id = s2.parent_singer_id
WHERE s.group_id IS NOT NULL
GROUP BY s.display_name
ORDER BY MIN(s.order), s.display_name
SQL
    Singer.find_by_sql(sql).map(&:display_name)
  end
end