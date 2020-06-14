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

  def _title
    return title if title.present?
    songs_parent.title
  end

  def _song_creators
    return song_creators if songs_parent.nil?
    # 直接 concat すると UPDATE が走るので一度 to_a
    song_creators.to_a.concat(songs_parent.song_creators)
  end

  class << self
    def list(id:, type:)
      case type
        when SongService::SearchType::ALL
          # ALL の時は読み仮名 50 音順
          res = songs_with_relations
            .order('songs.title_kana ASC')
        when SongService::SearchType::SONG
          res = songs_with_relations
            .where(songs: {id: id})
            .order('albums.sold_date ASC')
        when SongService::SearchType::SINGER
          # rin では NG、rin~raki とかでヒットする
          res = songs_with_relations
                  .where(songs: {id: SongSinger.where(singer_id: id).pluck(:song_id)})
                  .order('albums.sold_date ASC')
        else
          StandardError.new('invalid search type.')
      end
      res.where(songs: {parent_song_id: nil}).to_a
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
          .order('song_singers.display_order ASC')
          .order('song_creators.display_order ASC')
          .order('aitubes.order ASC')
    end
  end
end