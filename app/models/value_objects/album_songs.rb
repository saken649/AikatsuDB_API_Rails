module ValueObjects
  class AlbumSongs
    attr_reader :disc_number,
                :songs # Array<AlbumSong>

    def initialize(disc_number:)
      @disc_number = disc_number
      @songs = []
    end

    def push(album_song)
      @songs << album_song
    end
  end
end
