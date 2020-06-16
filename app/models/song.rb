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

  has_many :songs_children, class_name: 'Song', foreign_key: 'parent_song_id', dependent: :destroy
  belongs_to :songs_parent, class_name: 'Song', foreign_key: 'parent_song_id', optional: true

  scope :order_by_singer, -> { order('song_singers.display_order ASC') }
  scope :order_by_creator, -> { order('song_creators.display_order ASC') }
  scope :order_by_aitube, -> { order('aitubes.order ASC') }
  scope :default_order, -> { order_by_singer.order_by_creator.order_by_aitube }
  scope :order_by_title_kana, -> { order('songs.title_kana ASC') }
  scope :order_by_sold_date, -> { order('albums.sold_date ASC') }

  def _title
    return title if title.present?
    songs_parent.title
  end

  def _title_kana
    return title_kana if title_kana.present?
    songs_parent.title_kana
  end

  def _song_creators
    return song_creators if songs_parent.nil?
    # 直接 concat すると UPDATE が走るので一度 to_a
    song_creators.to_a.concat(songs_parent.song_creators)
  end

  class << self
    def list(id:, type:)
      # TODO: モデルを VSong に差し替え（リレーションも全部貼る）、並び順を 50 音順に統一する
      case type
        when SongService::SearchType::ALL
          # ALL の時は読み仮名 50 音順
          # バリエーションは後から足すので、order は樹にしない
          res = songs_with_relations
                  .where(songs: {parent_song_id: nil})
        # when SongService::SearchType::SONG
        #   res = songs_with_relations
        #           .where(songs: {id: id})
        #           .order('albums.sold_date ASC')
        when SongService::SearchType::SINGER
          # rin では NG、rin~raki とかでヒットする
          res = songs_with_relations
                  .where(songs: {id: SongSinger.where(singer_id: id).pluck(:song_id)})
                  .order_by_sold_date
        when SongService::SearchType::CREATOR
          res = songs_with_relations
                  .where(songs: {id: SongCreator.where(creator_id: id).pluck(:song_id).uniq})
                  .order_by_sold_date
        else
          StandardError.new('invalid search type.')
      end
      res.to_a
    end

    def song(song_id)
      songs_with_relations
        .where(songs: {id: song_id})
        .order('albums.sold_date ASC')
        .to_a
        .first
    end

    def songs_with_relations
      Song.includes(
            [
              :song_singers,
              :song_creators,
              :albums,
              :aitubes,
            ]
          )
          .preload(
            [
              :songs_parent,
              :songs_children,
              :singers,
              :creators,
              :song_albums,
              :series,
              singers: :group,
              albums: :album_tracks,
              creators: :production
            ]
          )
          .default_order
          .order_by_title_kana
    end
  end
end