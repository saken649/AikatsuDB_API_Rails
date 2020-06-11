class AlbumService
  class << self
    # アルバム詳細
    def detail(album_id)
      album = Album.detail(album_id)
      album_songs = album_songs(album)

      {
        album_id: album.id,
        title: album.title,
        sub_title: album.sub_title,
        sold_date: ::DateUtil.ymd(album.sold_date),
        image_path: ::ImageUtil.with_host(album.image_path),
        total_disc: album.album_tracks.maximum(:disc_number),
        songs: album_songs
      }
    end

    private

    # @param [ActiveRecord::Album] album
    # @return [Array<ValueObjects::AlbumSongs>]
    def album_songs(album)
      album_songs = album.song_albums
                         .map { |song_album| ::ValueObjects::AlbumSong.new(song: song_album.song, track_number: song_album.track_number, disc_number: song_album.disc_number) }
                         .group_by { |song_album| song_album.disc_number }
      ret = []
      album_songs.each do |disc_number, songs|
        as = ::ValueObjects::AlbumSongs.new(disc_number: disc_number)
        songs.sort_by { |s| s.track_number }.each do |song|
          as.push(song)
        end
        ret.push(as)
      end
      ret
    end
  end
end