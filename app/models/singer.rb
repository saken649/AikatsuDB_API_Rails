class Singer < ApplicationRecord
  has_many :song_singers
  has_many :songs, through: :song_singers

  has_many :singers_child, class_name: 'Singer', foreign_key: 'parent_singer_id', dependent: :destroy
  belongs_to :singers_parent, class_name: 'Singer', foreign_key: 'parent_singer_id', optional: true

  belongs_to :group, optional: true

  has_many :character_singers
  has_many :characters, through: :character_singers

  def name
    "#{name_family}#{name_first}"
  end

  def name_kana
    "#{name_family_kana}#{name_first_kana}"
  end

  def display_name_with_group
    "#{display_name} (#{group.name})"
  end

  class << self
    # 歌唱担当名前一覧
    # @return [Array<String>]
    def name_list
      sql = <<'SQL'
SELECT s.display_name FROM singers AS s
LEFT JOIN singers AS s2 ON s.id = s2.parent_singer_id
WHERE s.group_id IS NOT NULL
GROUP BY s.display_name
ORDER BY MIN(s.order), s.display_name
SQL
      Singer.find_by_sql(sql).map(&:display_name)
    end

    def list
      Singer.eager_load([:group, :singers_parent, singers_parent: :group])
            .where(singers: { has_children: 0 })
            .order('`groups`.`order` ASC')
            .to_a
    end

    def by_id(singer_id)
      Singer.eager_load([:group, :singers_parent, singers_parent: :group])
            .find_by(singers: { id: singer_id })
    end
  end
end