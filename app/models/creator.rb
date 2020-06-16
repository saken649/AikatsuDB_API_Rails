class Creator < ApplicationRecord
  has_many :song_creators
  has_many :songs, through: :song_creators

  belongs_to :production, optional: true

  class << self
    def list
      Creator.eager_load(:production, :song_creators)
             .all
             .order('COALESCE(name_family_kana, artist_name_kana) ASC')
             .to_a
    end

    def by_id(creator_id)
      Creator.eager_load(:production, :song_creators)
             .find_by(id: creator_id)
    end
  end
end