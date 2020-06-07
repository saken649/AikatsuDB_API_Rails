class SongService
  class << self
    # 楽曲リスト
    def list(song_id)
      songs = Song.list(song_id)
                  .map { |song| [song, variations(song)].compact }
                  .flatten
      songs(songs)
    end

    def detail(song_id)
      song = Song.song(song_id)
      return {} if song.blank?

      singers = ValueObjects::Singers.new(song)
      creators = ValueObjects::SongCreators.new(song._song_creators)
      albums = albums(song)
      parent_song = song.songs_parent.present? ? ValueObjects::Song.new(song.songs_parent) : nil
      variations = variations(song)
      variations = songs(variations) unless variations.blank?

      # TODO: Hash 直書きやめて Response クラス作る？→Ruby にそこまで期待しない方が？
      {
        song_id: song.id,
        title: song._title,
        sub_title: song.sub_title,
        # TODO: URL 直書きじゃなくて切り分ける
        aitube_url: song.aitubes.map { |aitube| "https://www.youtube-nocookie.com/embed/#{aitube.youtube_id}" },
        singer: singers.singers_with_group,
        creators: {
          lyrics: creators.lyrics,
          music: creators.music,
          arrangement: creators.arrangement,
          remix: creators.remix,
          all: creators.all
        },
        albums: albums,
        variations: {
          parent_song: parent_song,
          variations: variations
        }
      }
    end

    private

    def variations(song)
      variations = []
      if song.songs_children.present?
        song.songs_children.each do |child|
          variations << child
        end
      end
      if song.songs_parent.present?
        song.songs_parent.songs_children.each do |child|
          next if child.id == song.id
          variations << child
        end
      end
      variations
    end

    # @param [ActiveRecord::Song] songs
    # @return [Array<VAlueObject::Song>]
    def songs(songs)
      songs.map { |song| ValueObjects::Song.new(song) }
    end

    def albums(song)
      song_albums = song.song_albums.to_a.sort_by { |sa| sa.album.sold_date }
      song_albums.map do |song_album|
        ValueObjects::Album.new(
          id: song_album.album_id,
          title: song_album.album.title,
          sub_title: song_album.album.sub_title,
          sold_date: song_album.album.sold_date,
          image_path: song_album.album.image_path,
          disc_number: song_album.disc_number,
          disc_total: song_album.album.album_tracks.last.disc_number,
          track_number: song_album.track_number,
          track_total: song_album.album.album_tracks.last.tracks
        )
      end
    end
  end
end